class CalendarSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :date
  has_many :matters
end
