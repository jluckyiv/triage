class Event < ActiveRecord::Base
  belongs_to :case_number
  belongs_to :matter, :class_name => :CaseNumber,:foreign_key => "matter_id"

  alias_attribute :matter_id, :case_number_id

end
