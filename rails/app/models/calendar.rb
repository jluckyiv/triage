class Calendar < ActiveRecord::Base
  extend FriendlyId
  friendly_id :date

  has_many :matters
end
