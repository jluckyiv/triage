class Attorney < ActiveRecord::Base
  has_one :address, as: :addressable
  has_many :parties

  before_save :set_name_digest

  accepts_nested_attributes_for :address

  def set_name_digest
    self.name_digest = Digest::SHA1.hexdigest(name)
  end
end
