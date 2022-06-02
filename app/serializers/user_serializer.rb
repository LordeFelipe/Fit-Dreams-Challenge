class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate, :authentication_token, :role_id
  belongs_to :role
end
