class CbmMattersFactory

  attr_reader :data

  def initialize(data={})
    @params = HashWithIndifferentAccess.new(data)
    @validator = CbmQueryHearingsCacheValidator.new(matter_params)
    @parser = CbmQueryHearingsParser.new(matter_params)
  end

  def run(data={})
    if needs_update?
      create_matters(parser.run)
    end
    Array.wrap(matters_with_hearing_at_time)
  end

  private

  attr_reader :validator, :parser, :params

  def needs_update?
    validator.run == false || matters.count != parser.count
  end

  def matters
    Matter.where(matter_params)
  end

  def matters_with_hearing_at_time
    matters.select { |matter|
      matter.includes_hearing_at_time?(params[:time])
    }
  end

  def create_matters(object)
    Array.wrap(object).each do |data|
      return if data.include?("NOTHING")
      create_matter(data)
    end
  end
  handle_asynchronously :create_matters unless Rails.env.test?

  def create_matter(data)
    case_number = CaseNumberFactory.new(case_number_params(data)).run
    matter = case_number.matters.find_or_create_by(matter_params)
    create_hearings(matter, data)
  end

  def create_hearings(matter, data)
    Array.wrap(data['hearing']).each do |hearing_data|
      params = hearing_data.update(matter_id: matter.id)
      HearingFactory.new(params).run
    end
  end

  def matter_params
    {
      department: params.fetch(:department),
      date: params.fetch(:date)
    }
  end

  def case_number_params(data)
    {
      case_type: data.fetch('type'),
      case_number: data.fetch('number')
    }
  end

end

