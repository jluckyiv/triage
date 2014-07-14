class Department < ActiveRecord::Base
  belongs_to :courthouse
  has_many   :hearings
end
