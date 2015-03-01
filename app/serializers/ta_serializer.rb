class TaSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :full_name, :email

  has_many :open_help_requests
end
