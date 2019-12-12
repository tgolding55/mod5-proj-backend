class User < ApplicationRecord
    has_secure_password
    has_many :collaborators
    has_many :projects, through: :collaborators
    has_many :project_comments
    has_many :commented, through: :project_comments, source: :project
    validates :username, uniqueness: { case_sensitive: false }

    def github_name
        if self.github_access_token
            self.new_octokit.user.login
        else
            false
        end
    end

    def github_linked
        self.github_access_token
    end


    def new_octokit
        Octokit::Client.new(access_token: self.github_access_token)
    end
end
