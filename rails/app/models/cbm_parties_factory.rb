class CbmPartiesFactory

  attr_reader :case_number

  def initialize(data={})
    hash = HashWithIndifferentAccess.new(data)
    @case_number = CaseNumber.find_or_create_by(hash)
    @query_factory = CbmPartiesQueryFactory.new(hash)
    @parser = CbmPartiesQueryParser.new(hash)
  end

  def run
    if needs_update?
      create_parties
    end
    parties
  end

  def needs_update?
    parties.empty? || query_factory.needs_update?
  end

  private

  attr_reader :query_factory, :parser, :parties

  def parties
    Party.where(case_number: case_number)
  end

  def create_parties
    parser.run.each do |party|
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

