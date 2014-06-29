class MatterSerializer < ActiveModel::Serializer
  embed :ids, include: true

  has_one :calendar
  has_many :events

  attributes :id, :department, :case_number, :petitioner, :respondent,
    :petitioner_present, :respondent_present,
    :current_station, :checked_in

  def current_station
    return "Triage" if station.nil?
    station.attributes.fetch('subject') { "Triage" }
  end

  def checked_in
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

end
