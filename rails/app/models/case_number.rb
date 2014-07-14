class CaseNumber < ActiveRecord::Base
  has_many :hearings
  has_many :parties
  has_many :events

  def full_case_number
    "#{case_type}#{case_number}"
  end

end
