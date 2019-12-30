class User < ApplicationRecord
    has_secure_password
    has_many :collaborators
    has_many :projects, through: :collaborators
    has_many :project_comments
    has_many :commented, through: :project_comments, source: :project
    has_many :project_likes
    has_many :comment_likes
    has_many :project_messages

    validates :username, uniqueness: { case_sensitive: false }

    has_many :liked_users, foreign_key: :liker_id, class_name: 'UserLike'
    has_many :likees, through: :liked_users
    
    has_many :liking_users, foreign_key: :likee_id, class_name: "UserLike"
    has_many :likers, through: :liking_users

    def github_name
        if github_access_token
            new_octokit.user.login
        else
            false
        end
    end

    def github_linked
        !!github_access_token
    end

    def new_octokit
        Octokit::Client.new(access_token: github_access_token)
    end
end
