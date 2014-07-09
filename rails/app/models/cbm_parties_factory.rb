class CbmPartiesFactory

  attr_reader :case_number

  def initialize(data={})
    @case_number = CaseNumber.find_or_create_by(data)
    @query_factory = CbmPartiesQueryFactory.new(data)
    @parser = CbmPartiesQueryParser.new(data)
  end

  def run
    if query_factory.needs_update?
      parse
    end
    Party.where(case_number: case_number)
  end

  private

  attr_reader :query_factory, :parser

  def parse
    parser.run.each do |party|
      case_number.parties.find_or_create_by(attributes(party))
    end
  end

  def attributes(data)
    {
      number: data['number'],
      category: data['type'],
      first: data['name']['first'],
      middle: data['name']['middle'],
      last: data['name']['last'],
      suffix: data['name']['suffix']
    }
  end

end

