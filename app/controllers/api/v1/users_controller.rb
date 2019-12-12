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

    def dashboard
      projects = current_user.collaborators.map{|collaborator| ProjectSerializer.new(collaborator.project)}
      serializedUser = UserSerializer.new(current_user)
      render json: {user: serializedUser, projects: projects}, status: :ok
    end

    def index
      users = User.all.map{|user| UserSerializer.new(user)}
      render json: {users: users}, status: :ok
    end

    def create
      @user = User.create(user_params)
      if @user.valid?
        @token = encode_token(user_id: @user.id)
        render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
      else
        render json: { errors: ['failed to create user'] }, status: :not_acceptable
      end
    end

    def validate
      if logged_in?
        @token = encode_token(user_id: @user.id)
        render json: { user: UserSerializer.new(current_user), jwt: @token }, status: :created
      else
        render json: {errors: ["Invalid token"]}, status: :not_acceptable
      end
    end

    def github
      redirect_to "http://localhost:3000/auth/response?github_auth=" + auth_hash.credentials.token
    end

    def githubAuth
      if logged_in?
        github_auth = request.headers['Github']
        if !current_user.github_access_token
          current_user.update(github_access_token: github_auth)
        end
        @token = encode_token(user_id: @user.id)
        render json: { user: UserSerializer.new(current_user), jwt: @token}, status: :created
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

