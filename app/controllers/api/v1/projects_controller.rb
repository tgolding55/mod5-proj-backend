class Api::V1::ProjectsController < ApplicationController
    skip_before_action :authorized, only: [:index, :show]
    def index 
        projects = Project.all.map{|project| ProjectSerializer.new(project)}
        render json: {projects: projects}, status: :ok
    end

    def show
        project = Project.find(params["id"])
        collaborators = project.collaborators.map{|collaborator| UserSerializer.new(collaborator.user)}
        serializedProject = ProjectSerializer.new(project)
        render json: {project: serializedProject, collaborators: collaborators}, status: :ok
    end
end
