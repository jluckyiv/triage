class Matter < ActiveRecord::Base
  has_many :hearings
  has_many :parties
  has_many :events

  accepts_nested_attributes_for :hearings, :parties

  def full_case_number
    "#{case_type}#{case_number}"
  end

end
