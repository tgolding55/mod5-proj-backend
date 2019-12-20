class Project < ApplicationRecord
    has_many :collaborators
    has_many :users, through: :collaborators
    has_many :project_comments
    has_many :commenters, through: :project_comments, source: :user
    has_many :project_likes

    def collaborator_size
        self.collaborators.size 
    end

end
