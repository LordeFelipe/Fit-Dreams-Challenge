class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate, :authentication_token
  belongs_to :role

  def birthdate
    object.birthdate.strftime('%d/%m/%Y')
  end
end
