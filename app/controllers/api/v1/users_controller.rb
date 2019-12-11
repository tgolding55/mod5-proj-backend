class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create, :validate, :github, :githubAuth]
  
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

    def repos
      if current_user.github_access_token
        client = Octokit::Client.new(access_token: current_user.github_access_token)
        repos = client.repos.map{|repo| repo.name}
        @token = encode_token(user_id: @user.id)
        render json: repos, status: :created
      else
        render json: {errors: ["Not auther with github"], status: :not_acceptable}
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :password)
    end

    def auth_hash
      request.env['omniauth.auth']
    end

    def github?

    end
  end

