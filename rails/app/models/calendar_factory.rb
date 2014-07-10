class CalendarFactory

  attr_reader :adapter

  def initialize(options = {})
    hash = HashWithIndifferentAccess.new(options)
    @adapter = hash.fetch(:adapter) { CbmCalendarAdapter.new }
  end

  def run(data = {})
    @data = HashWithIndifferentAccess.new(data)
    departments.each_with_object([]) { |department, list|
      list.concat(matters_for(department))
    }
  end

  private
  attr_accessor :data, :departments, :date, :time

  def departments
    departments = Array.wrap(data.fetch(:departments) { %w[F201 F301 F401 F402] })
  end

  def date
    date = data.fetch(:date) { Date.today.strftime("%Y%m%d") }
  end

  def time
    time = data.fetch(:time) { "8.15" }
  end

  def matters_for(department)
    Array.wrap(adapter.run(department, date: date, time: time))
  end
end
