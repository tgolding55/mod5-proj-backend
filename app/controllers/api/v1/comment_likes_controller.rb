class Api::V1::CommentLikesController < ApplicationController
    def create
        comment = ProjectComment.find(params["comment_id"])
        user_liked = comment.comment_likes.find{|like| like.user_id === current_user.id}
        response = user_liked ? user_liked.destroy : CommentLike.create(user_id: current_user.id, project_comment_id: comment.id)
        render json: {user_like: response, liked: !!user_liked}
    end
end
