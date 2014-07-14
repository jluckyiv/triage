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
    calendar['cases'].each_with_object([]) do |kase, list|
      list << triage_entry(kase, calendar)
    end
  end

  def triage_entry(kase, calendar)
    petitioner = petitioner(kase)
    respondent = respondent(kase)
    entry = {}
    entry[:department] = calendar['department']
    entry[:id] = case_number(kase)
    entry[:petitioner] = name(petitioner)
    entry[:respondent] = name(respondent)
    entry[:petitioners_attorney] = attorney(petitioner)
    entry[:respondents_attorney] = attorney(respondent)
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
