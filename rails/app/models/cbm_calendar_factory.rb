class CbmCalendarFactory

  attr_reader :court_code, :departments, :calendars, :date, :time

  def initialize(data = {})
    @court_code = (data.fetch(:court_code) { "F" }).upcase.strip
    @date = (data.fetch(:date) { Date.today.strftime("%Y%m%d") }).strip
    @time = (data.fetch(:time) { "8.15" })
    @departments = Array.wrap(data.fetch(:departments) { ["F201", "F301", "F401", "F402"] })
  end

  def run
    generate_calendars
  end

  def generate_calendars
    calendar = Calendar.find_or_create_by(date: date)
    departments.each do |department|
      generate_case_list(calendar, department)
    end
    # departments.each_with_object([]) do |department, list|
      # calendar = Calendar.find_or_create_by(date: date, department: department)
      # generate_case_list(calendar)
      # list << calendar
    # end
  end

  def generate_case_list(calendar, department)
    parser = CbmHearingsQueryParser.new(hearings_hash(department))
    # return if calendar.md5 == parser.md5

    # calendar.update_attribute(:md5, parser.md5)
    Array.wrap(parser.cases).each do |kase|
      generate_case(calendar, department, kase)
    end
  end

  def generate_case(calendar, department, kase)
    case_number_hash = {
      court_code: court_code,
      case_type: kase['type'],
      case_number: kase['number']
    }
    case_number = CaseNumber.find_or_create_by(case_number_hash)
    generate_matter(calendar, department, kase, case_number)
  end

  def generate_matter(calendar, department, kase, case_number)
    return unless has_hearing_at_time(kase)
    matter = case_number.matters.find_or_create_by(calendar: calendar, department: department)
    Array.wrap(kase['hearing']).each do |hearing|
      md5 = Digest::MD5.hexdigest(hearing['description'])
      matter.hearings.find_or_create_by(md5: md5, time: hearing['time'])
    end
    generate_parties(case_number)
  end

  def generate_parties(case_number)
    parser = CbmPartiesQueryParser.new(case_number.to_h)
    return if case_number.parties_md5 == parser.md5

    case_number.update_attribute(:parties_md5, parser.md5)
    Array.wrap(parser.parties).each do |party|
      generate_party(case_number, party)
    end
  end

  def generate_party(case_number, party)
    party_hash = {
      number: party['number'].to_i,
      category: party['type'],
      first: party['name']['first'],
      middle: party['name']['middle'],
      last: party['name']['last'],
      suffix: party['name']['suffix']
    }
    case_number.parties.find_or_create_by(party_hash)
  end

  def has_hearing_at_time(kase)
    kase['hearing'].inspect.include? time
  end

  def hearings_hash(department)
    {
      court_code: court_code,
      date: date,
      department: department
    }
  end

end
