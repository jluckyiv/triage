class CaseNumber < ActiveRecord::Base
  has_many :matters
  has_many :parties

  def to_h
    {
      court_code: court_code,
      case_type: case_type,
      case_number: case_number
    }
  end

  def petitioner
    petitioner = parties_by_number(1)
    if petitioner.last.include? "COUNTY OF RIVERSIDE"
      petitioner = parties_by_number(3)
    end
    "#{petitioner.first} #{petitioner.last}"
  end

  def respondent
    respondent = parties_by_number(2)
    if respondent.last.include? "COUNTY OF RIVERSIDE"
      respondent = parties_by_number(3)
    end
    "#{respondent.first} #{respondent.last}"
  end

  def parties_by_number(number)
    parties.find { |party| party.number == number }
  end
end
