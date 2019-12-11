class UserSerializer < ActiveModel::Serializer
    attributes :username, :github_name
end
