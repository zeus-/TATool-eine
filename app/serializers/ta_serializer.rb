class TaSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email

  has_many :open_help_requests
end
