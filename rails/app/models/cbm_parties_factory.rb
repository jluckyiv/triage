class CbmPartiesFactory

  attr_reader :case_number

  def initialize(data={})
    hash = HashWithIndifferentAccess.new(data)
    @case_number = CaseNumber.find_or_create_by(hash)
    @validator = CbmQueryPartiesCacheValidator.new(hash)
    @parser = CbmQueryPartiesParser.new(hash)
  end

  def run
    if needs_update?
      create_parties(parser.run)
    end
    parties
  end

  def needs_update?
     validator.run == false
  end

  private

  attr_reader :validator, :parser, :parties

  def parties
    Party.where(case_number: case_number)
  end

  def create_parties(parties_objects)
    Array.wrap(parties_objects).each do |party|
      case_number.parties.find_or_create_by(attributes(party))
    end
  end
  handle_asynchronously :create_parties unless Rails.env.test?

  def attributes(party)
    {
      number: party['number'],
      category: party['type'],
      first: party['name']['first'],
      middle: party['name']['middle'],
      last: party['name']['last'],
      suffix: party['name']['suffix']
    }
  end

end

