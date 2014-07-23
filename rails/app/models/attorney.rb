class Attorney < ActiveRecord::Base

  include Hashable
  extend Hashable

  has_one :address, as: :addressable
  has_many :parties

  validates :name, presence: true
  validates :name_digest, presence: true, uniqueness: true

  before_validation :set_name_digest

  accepts_nested_attributes_for :address

  def set_name_digest
    self.name_digest = digest_for(name)
  end
end
