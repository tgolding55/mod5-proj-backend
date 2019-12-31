class Project < ApplicationRecord
    has_many :collaborators
    has_many :users, through: :collaborators
    has_many :project_comments
    has_many :commenters, through: :project_comments, source: :user
    has_many :project_likes
    has_many :project_messages

    validates :title, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 50}
    validates :description, presence: true
    validates :technologies_used, presence: true, length: {maximum: 40}
    validates :collaborator_size_limit, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 10}
    validates :status, presence: true
    validates :timeframe, presence: true, numericality: { greater_than: 0, less_than: 20}

    def collaborator_size
        self.collaborators.size 
    end

end
