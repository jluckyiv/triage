class NameSerializer < ActiveModel::Serializer

  embed :ids, include: true

  attributes :id, :first, :middle, :last, :suffix, :full

  def full
    "#{first} #{last}"
  end
end
