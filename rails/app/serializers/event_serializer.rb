class EventSerializer < ActiveModel::Serializer

  embed :ids, include: true

  has_one :matter

  attributes :id, :category, :subject, :action, :matter_id

end
