class UserSerializer < ActiveModel::Serializer
    attributes :id, :username, :github_linked, :bio
end