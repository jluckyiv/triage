class AddressSerializer < ActiveModel::Serializer

  embed :ids, include: true

  attributes :id, :street1, :street2, :city, :state, :zip

end
