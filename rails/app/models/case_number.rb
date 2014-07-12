class CaseNumber < ActiveRecord::Base
  has_many :matters
  has_many :parties

  def full_case_number
    "#{case_type}#{case_number}"
  end

  def to_h
    {
      court_code: court_code,
      case_type: case_type,
      case_number: case_number
    }
  end
end
