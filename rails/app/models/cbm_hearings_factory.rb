class CbmHearingsFactory

  attr_reader :data

  def initialize(data={})
    @params = data
    @query_factory = CbmHearingsQueryFactory.new(matter_params)
    @parser = CbmHearingsQueryParser.new(matter_params)
  end

  def run
    if query_factory.needs_update?
      create_matters
    end
    Matter.where(matter_params)
  end

  private

  attr_reader :query_factory, :parser, :params

  def create_matters
    matters_with_hearing_at_time.each do |data|
      create_matter(data)
    end
  end

  def matters_with_hearing_at_time
    parser.run.select { |matter_data|
      includes_hearing_at_time?(matter_data)
    }
  end

  def create_matter(data)
      case_number = CaseNumber.find_or_create_by(case_number_attributes(data))
      case_number.matters.find_or_create_by(matter_params)
  end

  def includes_hearing_at_time?(matter_data)
      params[:time].nil? || matter_data.inspect.include?(params[:time])
  end

  def matter_params
    {
      department: params.fetch(:department),
      date: params.fetch(:date)
    }
  end

  def case_number_attributes(data)
    {
      case_type: data.fetch('type'),
      case_number: data.fetch('number')
    }
  end

end

