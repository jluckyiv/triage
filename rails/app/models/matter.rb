class Matter < ActiveRecord::Base
  has_many :events, dependent: :destroy
  has_many :parties, dependent: :destroy
  has_many :proceedings, dependent: :destroy
  has_many :hearings, through: :proceedings

  accepts_nested_attributes_for :proceedings, :parties, reject_if: :no_matter

  validates :court_code, presence: true
  validates :case_type, presence: true
  validates :case_number, presence: true, uniqueness: { scope: [:case_type] }

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

  def proceedings_attributes=(attributes)
    Array.wrap(attributes).each do |attrs|
      description_digest = Proceeding.digest_for(attrs['description'])
      unless proceeding = proceedings.find_by(description_digest: description_digest)
        proceeding = proceedings.build(attrs)
      end
    end
  end

  def parties_attributes=(attributes)
    Array.wrap(attributes).each do |attrs|
      unless party = parties.find_by(number: attrs['number'])
        party = parties.build(attrs)
      end
    end
  end

end
