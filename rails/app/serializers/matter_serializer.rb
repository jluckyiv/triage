class MatterSerializer < ActiveModel::Serializer
  attributes :id, :department, :case_number, :petitioner, :respondent,
    :petitioner_present, :respondent_present
  has_many :events

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
