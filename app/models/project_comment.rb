class ProjectComment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :comment_likes
end
