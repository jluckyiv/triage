class AttorneySerializer < ActiveModel::Serializer

  embed :ids, include: true

  has_one :address
  has_many :parties

  attributes :id, :name, :email, :phone, :sbn

end
