class Courthouse < ActiveRecord::Base
  has_many :departments
  has_one  :address, as: :addressable
end
