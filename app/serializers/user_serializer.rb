class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate, :authentication_token, :role_id
  # has_one :role
end
