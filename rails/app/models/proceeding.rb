class Proceeding < ActiveRecord::Base
  include Hashable

  belongs_to :matter
  has_many   :hearings, dependent: :destroy

  before_validation :set_description_digest

  validates :description_digest, presence: true, uniqueness: true

  def set_description_digest
    self.description_digest = digest_for(description)
  end
end
