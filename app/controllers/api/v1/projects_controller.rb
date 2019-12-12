class Api::V1::ProjectsController < ApplicationController
    skip_before_action :authorized, only: [:index, :show]
    def index 
        projects = Project.all.map{|project| ProjectSerializer.new(project)}
        render json: {projects: projects}, status: :ok
    end

    def show
        project = Project.find(params["id"])
        collaborators = project.collaborators.map{|collaborator| UserSerializer.new(collaborator.user)}
        comments = project.project_comments.map{|comment| {content: comment.content, user: {username:comment.user.username, id: comment.user.id}}}.reverse
        serializedProject = ProjectSerializer.new(project)
        render json: {project: serializedProject, collaborators: collaborators, comments: comments}, status: :ok
    end
end
