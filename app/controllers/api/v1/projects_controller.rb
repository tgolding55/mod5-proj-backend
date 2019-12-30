class Api::V1::ProjectsController < ApplicationController
    skip_before_action :authorized, only: [:index, :show]
    def index    
        projects = Project.all.map{ |project| ProjectSerializer.new(project)}
        render json: {projects: projects}, status: :ok
    end

    def show
        project = Project.find(params["id"])
        collaborators = project.collaborators.map{ |collaborator| {id: collaborator.user.id, username: collaborator.user.username, github_linked: collaborator.user.github_linked, bio: collaborator.user.bio, likees: collaborator.user.likees, role: collaborator.role}}
        comments = project.project_comments.map{|comment| {comment_id:comment.id, content: comment.content, likes: comment.comment_likes, user: {username:comment.user.username, id: comment.user.id}}}.reverse
        serializedProject = ProjectSerializer.new(project)
        render json: {project: serializedProject, collaborators: collaborators, comments: comments}, status: :ok
    end

    def edit
        project = Project.find(params["id"])
        if project.users.include?(current_user)
            collaborators = project.collaborators.map{ |collaborator| {id: collaborator.user.id, username: collaborator.user.username, github_linked: collaborator.user.github_linked, bio: collaborator.user.bio, likees: collaborator.user.likees, role: collaborator.role}}
            comments = project.project_comments.map{|comment| {comment_id:comment.id, content: comment.content, likes: comment.comment_likes, user: {username:comment.user.username, id: comment.user.id}}}.reverse
            messages = project.project_messages.map{|message| {content: message.content, user: UserSerializer.new(message.user)}}
            serializedProject = ProjectSerializer.new(project)
            render json: {project: serializedProject, collaborators: collaborators, comments: comments, messages: messages}, status: :ok
        else
            render json: {errors: ["User not a collaborator"]}, status: :not_acceptable
        end
    end

    def update
        project = Project.find(params["id"])
        if project.users.include?(current_user)
            if project.update(project_params)
                collaborators = project.collaborators.map{ |collaborator| {id: collaborator.user.id, username: collaborator.user.username, github_linked: collaborator.user.github_linked, bio: collaborator.user.bio, likees: collaborator.user.likees, role: collaborator.role}}
                comments = project.project_comments.map{|comment| {comment_id:comment.id, content: comment.content, likes: comment.comment_likes, user: {username:comment.user.username, id: comment.user.id}}}.reverse
                messages = project.project_messages.map{|message| {content: message.content, user: UserSerializer.new(message.user)}}
                serializedProject = ProjectSerializer.new(project)
                render json: {project: serializedProject, collaborators: collaborators, comments: comments,messages: messages}, status: :ok
            else
                render json: {errors: ["Could not update"]}, status: :not_acceptable
            end
        else
            render json: {errors: ["User not a collaborator"]}, status: :not_acceptable
        end
    end

    def create
        if current_user.github_linked
            project = Project.create(project_params)
            if project.valid? 
                Collaborator.create(project_id: project.id, user_id: current_user.id, role: "lead")
                render json: {project: project}, status: :ok
            else
                render json: {errors: ["Project invalid"]}, status: :not_acceptable
            end
        else    
            render json: {errors: ["Not authed with github!"]}, status: :not_authorized
        end
    end

    def like
        project = Project.find(params["id"])
        user_liked = project.project_likes.find{|like| like.user_id == current_user.id}
        response = user_liked ? user_liked.destroy : ProjectLike.create(user_id: current_user.id, project_id: project.id)
        render json: {user_like: response, liked: !!user_liked}, status: :ok
    end

    def repo
        project = Project.find(params["id"])
        if current_user.github_linked
            octokit = current_user.new_octokit
            github_repo = octokit.create_repository(repo_params[:title])
            project.update(github_link: github_repo.html_url)
            project.collaborators.map{|collaborator| collaborator.user != current_user && octokit.add_collab(github_repo.full_name, collaborator.user.github_name)}
            render json: {project:ProjectSerializer.new(project) }, status: :ok
        else
            render json: {errors: ["Not authed with github!"]}, status: :not_authorized
        end
    end

    private

    def project_params 
        params.require(:project).permit(:title, :technologies_used,:description,:collaborator_size_limit,:status, :timeframe, :github_link)
    end

    def repo_params
        params.require(:projectDetails).permit(:title)
    end
end
