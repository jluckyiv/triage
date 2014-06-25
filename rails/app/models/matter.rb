class Matter < ActiveRecord::Base
  belongs_to :calendar
  has_many :events
end
