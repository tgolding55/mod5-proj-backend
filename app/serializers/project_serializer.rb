class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :technologies_used, :collaborator_size_limit, :collaborator_size, :status
end
