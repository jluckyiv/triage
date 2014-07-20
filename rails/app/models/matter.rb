class Matter < ActiveRecord::Base
  has_many :hearings
  has_many :parties
  has_many :events

  accepts_nested_attributes_for :hearings, :parties

  validates :court_code, presence: true
  validates :case_type, presence: true
  validates :case_number, presence: true

  class << self
    def find_by_full_case_number(full_case_number)
      case_number = CaseNumberParser.parse(full_case_number)
      find_by(case_number)
    end

    def create_with_full_case_number(full_case_number)
      case_number = CaseNumberParser.parse(full_case_number)
      create(case_number)
    end

    def find_or_create_by_full_case_number(full_case_number)
      case_number = CaseNumberParser.parse(full_case_number)
      find_or_create_by(case_number)
    end

  end
end
