class CommentLike < ApplicationRecord
  belongs_to :user
  belongs_to :project_comment
end
