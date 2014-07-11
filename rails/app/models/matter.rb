class Matter < ActiveRecord::Base
  belongs_to :case_number

  has_many :hearings
  has_many :events

  delegate :petitioner, to: :case_number
  delegate :respondent, to: :case_number

end
