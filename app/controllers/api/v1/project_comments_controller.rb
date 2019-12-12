class Api::V1::ProjectCommentsController < ApplicationController
    def create
        comment = ProjectComment.new(project_comment_params)
        comment.user_id = current_user.id
        comment.save
        render json: {comment: {content: comment.content,likes: comment.comment_likes, user: {username:comment.user.username, id: comment.user.id}}}
    end

    private

    def project_comment_params
        params.require(:comment).permit(:content, :project_id)
    end
end
