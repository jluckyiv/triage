class MatterSerializer < ActiveModel::Serializer

include ActionView::Helpers::DateHelper

  embed :ids, include: true

  has_many :events
  # has_many :parties
  # has_many :hearings

  attributes :id, :department, :case_number, :petitioner, :respondent, :interpreter,
    :petitioner, :respondent, :petitioner_present, :respondent_present,
    :current_station, :checked_in, :last_disposition, :current_delay

  def events
    date = object.hearings.last.date_time
    object.events.where(created_at: date.beginning_of_day..date.end_of_day)
  end

  def case_number
    "#{object.case_type}#{object.case_number}"
  end

  def department
    object.hearings.last.department.name
  end

  def interpreter
    object.hearings.last.interpreter || "English"
  end

  def current_station
    return "Triage" if station.nil?
    station.attributes.fetch('subject') { "Triage" }
  end

  def current_delay
    if station
      "#{station.action} #{time_ago_in_words(station.created_at)} ago"
    end
  end

  def checked_in
    return true if station.nil? && petitioner_present && respondent_present
    return false if station.nil?
    return true if station.action.include? "arrive"
    return false
  end

  def last_disposition
    if last_dispo = events.where(category: "disposition").last
      "#{last_dispo.subject}, #{last_dispo.action}, #{time_ago_in_words(last_dispo.created_at)} ago"
    end
  end

  def petitioner
    petitioner = substitute_riverside_county(find_petitioner) || placeholder
    "#{petitioner.name.first} #{petitioner.name.last}"
  end

  def respondent
    respondent = substitute_riverside_county(find_respondent) || placeholder
    "#{respondent.name.first} #{respondent.name.last}"
  end

  def petitioner_present
    is_present?("petitioner")
  end

  def respondent_present
    is_present?("respondent")
  end

  private

  def station
    @station ||= events.where({
      category: "station",
      created_at: Time.now.beginning_of_day..Time.now.end_of_day
    }).last
  end

  def is_present?(party)
    last_appearance = events.where({
      category: "appearance", subject: party
    }).last
    return false if last_appearance.nil?
    return true if last_appearance.action == "checkin"
    return false
  end

  def placeholder
    OpenStruct.new(name: OpenStruct.new(first: "Loading", last: ""))
  end

  def find_petitioner
    party_by_role("PETITIONER") || party_by_number(1)
  end

  def find_respondent
    party_by_role("RESPONDENT") || party_by_number(2)
  end

  def substitute_riverside_county(party)
    return party if party.nil?
    unless party.name.last.include? "COUNTY OF RIVERSIDE"
      return party
    else
      return party_by_role("OTHER PARENT") || party_by_number(3)
    end
  end

  def party_by_number(number)
    object.parties.find { |party| party.number == number }
  end

  def party_by_role(role)
    object.parties.find { |party| party.role.upcase.include?(role.upcase) }
  end

end
