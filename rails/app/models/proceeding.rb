class Proceeding < ActiveRecord::Base

  include Hashable
  extend Hashable

  belongs_to :matter
  has_many   :hearings, dependent: :destroy

  accepts_nested_attributes_for :hearings

  before_validation :set_description_digest

  validates :description_digest, presence: true, uniqueness: true
  # validates :matter_id, presence: true

  def set_description_digest
    self.description_digest = digest_for(description)
  end

  def hearings_attributes=(attributes)
    Array.wrap(attributes).each do |attrs|
      unless hearing = hearings.find_by(attrs)
        hearing = hearings.build(attrs)
      end
    end
  end

end
