class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create, :validate, :github, :githubAuth, :index, :show]

    def show
      user = User.find(params["id"])
      projects = user.collaborators.map{|collaborator| ProjectSerializer.new(collaborator.project)}
      serializedUser = UserSerializer.new(user)
      render json: {user: serializedUser, projects: projects}, status: :ok
    end

    def like
      liked_user = User.find(params["like_id"])
      to_like = liked_user.likees.find{|likee| likee.id === current_user.id}
      !!to_like ? liked_user.likees.delete(to_like) : liked_user.likees << current_user 
    
      render json: liked_user.likees, status: :ok
    end

    def repos
      if current_user.github_linked
        page = params[:page]
        octokit = current_user.new_octokit
        pages = (octokit.user.public_repos / 30.0).ceil
        
        repos = octokit.repos(nil, {page:page}).map{|repo| {title: repo.name, technologies_used: repo.language, description: repo.description, github_link: repo.html_url}}
        
        render json: {repos: repos, page_length: pages, page: page}, status: :ok
      end
    end

    def update 
      if current_user.id === params["user"]["id"]
        if current_user.update(user_params)
          serializedUser = UserSerializer.new(current_user)
          render json: {user: serializedUser}, status: :ok
        else
          render json: {errors: ["Could not update"]}, status: :not_acceptable
        end
      else
        render json: [errors: "You cannot edit this user!"], status: :not_acceptable
      end
    end

    def dashboard
      projects = current_user.collaborators.map{|collaborator| ProjectSerializer.new(collaborator.project)}
      serializedUser = UserSerializer.new(current_user)
      liked_projects = current_user.project_likes.map{|projectlike| ProjectSerializer.new(projectlike.project)}
      liked_users = current_user.liking_users.map{|liked_user| UserSerializer.new(liked_user.liker)}
      liking_users = current_user.liked_users.map{|liked_user| UserSerializer.new(liked_user.liker)}
      render json: {user: serializedUser, projects: projects, liked_projects: liked_projects, liked_users: liked_users, liking_users: liking_users}, status: :ok
    end

    def index
      users = User.all.map{|user| UserSerializer.new(user)}
      render json: {users: users}, status: :ok
    end

    def create
      
      if !User.find_by({username:  params[:user][:username]})
        @user = User.create(user_params)
        if @user.valid?
          @token = encode_token(user_id: @user.id)
          render json: { user: UserSerializer.new(@user), jwt: @token }, status: :ok
        else
          render json: { errors: ['Failed to create user'] }, status: :not_acceptable
        end
      else
        render json: { errors: ['Username taken']}, status: :not_acceptable
      end
    end

    def validate
      if logged_in?
        @token = encode_token(user_id: @user.id)
        render json: { user: UserSerializer.new(current_user), jwt: @token }, status: :ok
      else
        render json: {errors: ["Invalid token"]}, status: :not_acceptable
      end
    end

    def github
      redirect_to "http://209.97.189.241:5000/auth/response?github_auth=" + auth_hash.credentials.token
    end

    def githubAuth
      if logged_in?
        github_auth = request.headers['Github']
        if !current_user.github_access_token
          current_user.update(github_access_token: github_auth)
        end
        @token = encode_token(user_id: @user.id)
        render json: { user: UserSerializer.new(current_user), jwt: @token}, status: :ok
      else
        render json: {errors: ["Could not auth github"], status: :not_acceptable}
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :password, :bio)
    end

    def auth_hash
      request.env['omniauth.auth']
    end
  end

