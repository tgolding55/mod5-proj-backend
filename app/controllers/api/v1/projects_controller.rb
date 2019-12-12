class Api::V1::ProjectsController < ApplicationController
    skip_before_action :authorized, only: [:index, :show]
    def index    
        projects = Project.all.map{ |project| serializedProject = ProjectSerializer.new(project)}
        render json: {projects: projects}, status: :ok
    end

    def show
        project = Project.find(params["id"])
        collaborators = project.collaborators.map{|collaborator| UserSerializer.new(collaborator.user)}
        comments = project.project_comments.map{|comment| {id:comment.id, content: comment.content, likes: comment.comment_likes, user: {username:comment.user.username, id: comment.user.id}}}.reverse
        serializedProject = ProjectSerializer.new(project)
        render json: {project: serializedProject, collaborators: collaborators, comments: comments}, status: :ok
    end

    def like
        project = Project.find(params["id"])
        user_liked = project.project_likes.find{|like| like.user_id == current_user.id}
        response = user_liked ? user_liked.destroy : ProjectLike.create(user_id: current_user.id, project_id: project.id)
        render json: {user_like: response, liked: !!user_liked}
    end

end
