class ProjectMessage < ApplicationRecord
  belongs_to :project
  belongs_to :user
end
