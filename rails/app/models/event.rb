class Event < ActiveRecord::Base
  belongs_to :matter

  validates :matter, presence: true
  validates :category, presence: true
  validates :subject, presence: true
  validates :action, presence: true
end
