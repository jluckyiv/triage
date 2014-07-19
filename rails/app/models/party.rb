class Party < ActiveRecord::Base
  belongs_to :matter
  belongs_to :attorney
  has_one :name, as: :nameable
  has_one :address, as: :addressable

  accepts_nested_attributes_for :address, :attorney, :name
end
