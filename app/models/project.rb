class Project < ApplicationRecord
    has_many :collaborators
    has_many :users, through: :collaborators

    def collaborator_size
        self.collaborators.size 
    end
end
