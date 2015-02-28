class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email

  has_many :help_requests
end
