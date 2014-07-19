class Api::V1::Cbm::Triage::MattersController < Api::V1::Cbm::CalendarsController

  def index
    @date        = params[:date].nil? ? today : URI.escape(params[:date])
    @time        = "8.15"
    @departments = %w[F201 F301 F401 F402 F501 F502]
    @cc          = "F"
    render json: triage_calendar
  end

  def show
    @date        = params[:id].nil? ? today : URI.escape(params[:id])
    @time        = "8.15"
    @departments = %w[F201 F301 F401 F402 F501 F502]
    @cc          = "F"
    render json: triage_calendar
  end

  def triage_calendar
    filtered_calendars.each_with_object([]) { |calendar, list|
      list.concat(triage_entries(calendar))
    }
  end

  def triage_entries(calendar)
    calendar['cases'].each_with_object([]) do |matter, list|
      list << triage_entry(matter, calendar)
    end
  end

  def triage_entry(matter, calendar)
    matter = matter.find_or_create_by(court_code: cc, case_type: matter['type'], case_number: matter['number'])
    petitioner = petitioner(matter)
    respondent = respondent(matter)
    entry = {}
    entry[:id] = matter.id
    entry[:case_number] = matter.full_case_number
    entry[:department] = calendar['department']
    entry[:petitioner] = name(petitioner)
    entry[:respondent] = name(respondent)
    entry[:petitioner_present] = petitioner_present?(matter)
    entry[:respondent_present] = respondent_present?(matter)
    entry[:petitioners_attorney] = attorney(petitioner)
    entry[:respondents_attorney] = attorney(respondent)
    entry[:events] = matter.events
    entry[:current_station] = current_station(matter)
    entry[:checked_in] = checked_in?(matter)
    entry
  end

  def case_number(kase)
    "#{kase['type']}#{kase['number']}"
  end

  def petitioner(kase)
    party(kase, "petitioner", 1)
  end

  def respondent(kase)
    party(kase, "respondent", 2)
  end

  def petitioner_present?(case_number)
    is_present?("petitioner", case_number)
  end

  def respondent_present?(case_number)
    is_present?("respondent", case_number)
  end

  def current_station(case_number)
    station = case_number.events.where({ category: "station" }).last
    return "Triage" if station.nil?
    station.attributes.fetch('subject') { "Triage" }
  end

  def checked_in?(case_number)
    station = case_number.events.where({ category: "station" }).last
    return false if station.nil?
    return true if station.action == "arrive"
    return false
  end

  private

  def is_present?(role, case_number)
    last_appearance = case_number.events.where({
      category: "appearance", subject: role
    }).last
    return false if last_appearance.nil?
    return true if last_appearance.action == "checkin"
    return false
  end

  def party(kase, role, number)
    parties = kase['parties']
    unless party = find_party_by_role(parties, role)
      party = find_party_by_number(parties, number)
    end
    party
  end

  def find_party_by_role(parties, role)
    party = parties.find {|p| p['type'].strip.downcase == role.strip.downcase }
    if dcss?(party)
      party = find_party_by_role(parties, "other parent")
    end
    party
  end

  def find_party_by_number(parties, number)
    party = parties.find {|p| p['number'].to_i == number.to_i }
    if dcss?(party)
      party = find_party_by_number(parties, 3)
    end
    party
  end

  def dcss?(party)
    name(party).downcase.include?("county of") && attorney(party).downcase.include?("department of child support")
  end

  def name(party)
    "#{party['name']['first']} #{party['name']['last']}"
    # name = name_parser.parse("#{party['name']['first']} #{party['name']['last']}")
    # "#{name[:first]} #{name[:last]}"
  end

  def attorney(party)
    attorney = party['attorney']['name']
    attorney unless unrepresented?(attorney)
  end

  def unrepresented?(attorney)
    ["pro per", "unrepresented"].include?(attorney.squeeze(' ').strip.downcase)
  end

end
