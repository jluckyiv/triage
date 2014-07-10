class CbmCalendarFactory

  attr_reader :court_code, :departments, :calendars, :date, :time

  def initialize(data = {})
    hash = HashWithIndifferentAccess.new(data)
    @court_code = (hash.fetch(:court_code) { "F" }).upcase.strip
    @date = (hash.fetch(:date) { Date.today.strftime("%Y%m%d") }).strip
    @time = (hash.fetch(:time) { nil })
    @departments = Array.wrap(hash.fetch(:departments) { ["F201", "F301", "F401", "F402"] })
  end

  def run
    departments.each_with_object([]) { |department, list|
      list.concat(matters_for_department(department))
    }.each do |matter|
      parties_for_matter(matter)
    end
  end

  private

  def matters_for_department(department)
    matters = CbmHearingsFactory.new(department: department, date: date, time: time).run
  end

  def parties_for_matter(matter)
    CbmPartiesFactory.new(matter.case_number.attributes).run
  end

end
