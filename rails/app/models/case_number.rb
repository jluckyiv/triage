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

  def petitioner
    petitioner = substitute_riverside_county(find_petitioner)
    "#{petitioner.first} #{petitioner.last}"
  end

  def respondent
    respondent = substitute_riverside_county(find_respondent)
    "#{respondent.first} #{respondent.last}"
  end

  private

  def find_petitioner
    parties_by_category("PETITIONER") || parties_by_number(1)
  end

  def find_respondent
    parties_by_category("RESPONDENT") || parties_by_number(2)
  end

  def substitute_riverside_county(party)
    if party.last.include? "COUNTY OF RIVERSIDE"
      return parties_by_number(3)
    else
      return party
    end
  end

  def parties_by_number(number)
    parties.find { |party| party.number == number }
  end

  def parties_by_category(category)
    parties.find { |party| party.category.upcase.include?(category.upcase) }
  end
end
