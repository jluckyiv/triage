class Calendar < ActiveRecord::Base
  extend FriendlyId
  friendly_id :date
end
