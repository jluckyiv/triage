class MatterSerializer < ActiveModel::Serializer
  embed :ids, include: true

  has_many :events

  attributes :id, :department, :case_number, :petitioner, :respondent,
    :petitioner, :respondent, :petitioner_present, :respondent_present,
    :current_station, :checked_in

  def case_number
    "#{object.case_number.case_type}#{object.case_number.case_number}"
  end

  def current_station
    return "Triage" if station.nil?
    station.attributes.fetch('subject') { "Triage" }
  end

  def checked_in
    return false if station.nil?
    return true if station.action == "arrive"
    return false
  end

  def petitioner
    petitioner = substitute_riverside_county(find_petitioner) || placeholder
    "#{petitioner.first} #{petitioner.last}"
  end

  def respondent
    respondent = substitute_riverside_county(find_respondent) || placeholder
    "#{respondent.first} #{respondent.last}"
  end

  def petitioner_present
    is_present?("petitioner")
  end

  def respondent_present
    is_present?("respondent")
  end

  private

  def station
    @station ||= object.events.where({ category: "station" }).last
  end

  def is_present?(party)
    last_appearance = object.events.where({
      category: "appearance", subject: party
    }).last
    return false if last_appearance.nil?
    return true if last_appearance.action == "checkin"
    return false
  end

  def placeholder
    OpenStruct.new(first: "Loading", last: "")
  end

  def find_petitioner
    parties_by_category("PETITIONER") || parties_by_number(1)
  end

  def find_respondent
    parties_by_category("RESPONDENT") || parties_by_number(2)
  end

  def substitute_riverside_county(party)
    return party if party.nil?
    unless party.last.include? "COUNTY OF RIVERSIDE"
      return party
    else
      return parties_by_number(3)
    end
  end

  def parties_by_number(number)
    object.case_number.parties.find { |party| party.number == number }
  end

  def parties_by_category(category)
    object.case_number.parties.find { |party| party.category.upcase.include?(category.upcase) }
  end

end
