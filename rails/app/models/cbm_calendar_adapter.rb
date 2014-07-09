class CbmCalendarAdapter

  attr_reader :department, :date, :time
  def run(department, options = {})
    @department = department
    @date = options.fetch(date) { Date.today.strftime("%Y&m&d") }
    @time = options.fetch(time) { "8.15" }
    matters
  end

  def attributes
    {
      department: department,
      date: date,
      time: time
    }
  end

  private

  def matters
    query = CbmHearingsQuery.new(attributes)
    cache = CbmHearingsQueryCache.new(attributes)
  end
end
