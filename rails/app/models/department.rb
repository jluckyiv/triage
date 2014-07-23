class Department < ActiveRecord::Base
  belongs_to :courthouse
  has_many   :hearings

  validates :name, presence: true, uniqueness: { scope: [:courthouse_id] }

end
