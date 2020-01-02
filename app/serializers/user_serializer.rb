class UserSerializer < ActiveModel::Serializer
    attributes :id, :username, :github_linked, :bio, :likees, :created_at
end
