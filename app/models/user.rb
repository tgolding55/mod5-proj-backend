class User < ApplicationRecord
    has_secure_password
    has_many :collaborators
    has_many :projects, through: :collaborators
    has_many :project_comments
    has_many :commented, through: :project_comments, source: :project
    has_many :project_likes
    has_many :comment_likes
    validates :username, uniqueness: { case_sensitive: false }

    def github_name
        if github_access_token
            new_octokit.user.login
        else
            false
        end
    end

    def github_linked
        github_access_token
    end

    def new_octokit
        Octokit::Client.new(access_token: github_access_token)
    end
end
