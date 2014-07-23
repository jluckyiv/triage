class Hearing < ActiveRecord::Base
  belongs_to :proceeding
  belongs_to :department

  validates :date_time, uniqueness: { scope: [:proceeding_id, :department_id] }

end
