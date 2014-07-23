class Courthouse < ActiveRecord::Base
  has_many :departments
  has_one  :address, as: :addressable

  validates :branch_name, presence: true, uniqueness: { scope: [:county] }

end
