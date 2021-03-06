class Api::V1::SearchsController < ApplicationController
    skip_before_action :authorized, only: [:search]
    def search
        if params["search"].length > 0
            users = User.where("lower(username) like ?", "%#{params["search"].downcase}%").map{|user| UserSerializer.new(user)}
            projects = Project.where("lower(title) like ?", "%#{params["search"].downcase}%").map{|project| ProjectSerializer.new(project)}
            if users.length > 0 || projects.length > 0
                render json: {search: params["search"], users: users, projects: projects}, status: :ok
            else
                render json: {errors: ["No search results found"]}, status: :not_acceptable
            end
        else
            render json: {errors: ["Search must have content"]}, status: :not_acceptable
        end
    end
end