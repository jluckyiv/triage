class MattersFactory

  attr_reader :data

  def initialize(data={})
    @params = HashWithIndifferentAccess.new(data)
  end

  def run
    Array.wrap(matters_with_hearing_at_time)
  end

  private

  attr_reader :params

  def matters_with_hearing_at_time
    matters.select { |matter|
      includes_hearing_at_time?(matter)
    }
  end

  def matters
    Matter.where(matter_params)
  end

  def includes_hearing_at_time?(matter)
    time = params[:time]
    time.nil? || matter.hearings.any? {|hearing|
      hearing.time.include?(time)
    }
  end

  def matter_params
    {
      department: params.fetch(:departments),
      date: params.fetch(:date)
    }
  end

end

