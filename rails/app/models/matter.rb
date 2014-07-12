class Matter < ActiveRecord::Base
  belongs_to :case_number

  has_many :hearings
  has_many :events

  def includes_hearing_at_time?(time)
    time.nil? || hearings.any? {|hearing|
      hearing.time.include?(time)
    }
  end

end
