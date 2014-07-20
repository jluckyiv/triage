class Attorney < ActiveRecord::Base
  has_one :address, as: :addressable
  has_many :parties

  before_save :set_name_digest

  accepts_nested_attributes_for :address

  class << self
    def digest_for(data)
      Digest::SHA1.hexdigest(data)
    end
  end

  def set_name_digest
    self.name_digest = Attorney.digest_for(name)
  end
end
