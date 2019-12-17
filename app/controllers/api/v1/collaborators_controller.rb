class Api::V1::CollaboratorsController < ApplicationController
    def create
        if !Project.find(params[:id]).collaborators.find_by(user_id: current_user.id)
            collaborator = Collaborator.create(project_id: params[:id], user_id:current_user.id, role: "user")
            user = collaborator.user
            render json: {collaborator: UserSerializer.new(user)}, status: :ok
        else
            render json: {errors: ["User already a collaborator"]}, status: :not_acceptable
        end
    end
end
