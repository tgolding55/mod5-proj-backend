class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }

    def github_name
        if self.github_access_token
            self.new_octokit.user.login
        else
            ""
        end
    end


    def new_octokit
        if self.github_access_token 
            Octokit::Client.new(access_token: self.github_access_token)
        end
    end
end
