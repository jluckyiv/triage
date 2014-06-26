class MatterSerializer < ActiveModel::Serializer
  attributes :id, :department, :case_number, :petitioner, :respondent,
    :petitioner_present, :respondent_present, :current_station, :checked_in
  has_many :events

  def current_station
    station = object.events.where({ category: "station" }).last
    return "Triage" if station.nil?
    station.attributes.fetch('subject') { "Triage" }
  end

  def checked_in
    station = object.events.where({ category: "station" }).last
    return false if station.nil?
    return true if station.action == "arrive"
    return false
  end

  def petitioner_present
    is_present?("petitioner")
  end

  def respondent_present
    is_present?("respondent")
  end

  def is_present?(party)
    last_appearance = object.events.where({
      category: "appearance", subject: party
    }).last
    return false if last_appearance.nil?
    return true if last_appearance.action == "checkin"
    return false
  end

end
