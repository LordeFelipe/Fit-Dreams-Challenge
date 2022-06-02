class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate, :authentication_token
  belongs_to :role
end
