class PartySerializer < ActiveModel::Serializer

  embed :ids, include: true

  has_one :matter
  has_one :name
  has_one :address
  has_one :attorney

  attributes :id
end
