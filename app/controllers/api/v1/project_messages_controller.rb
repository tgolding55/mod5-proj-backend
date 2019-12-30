class Api::V1::ProjectMessagesController < ApplicationController

    def show
      project = Project.find(params[:id])
      messages = project.project_messages.map{|message| {content: message.content, user: UserSerializer.new(message.user)}}
      render json: {messages: messages}, status: :ok
    end

    def create
      message = ProjectMessage.create(message_params)
      message.user_id = current_user.id
      if message.save
        message = {content: message.content, user: UserSerializer.new(message.user)}
        render json: {message: message}, status: :ok
      else
        render json: {errors: ["Message not created!"]}, status: :not_acceptable
      end
    end

    private
  
    def message_params
      params.require(:message).permit(:content, :project_id)
    end
  
end
