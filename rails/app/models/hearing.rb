class Hearing < ActiveRecord::Base
  belongs_to :matter
  belongs_to :department

  before_save :set_description_digest

  def set_description_digest
    self.description_digest = Digest::SHA1.hexdigest(description)
  end
end
