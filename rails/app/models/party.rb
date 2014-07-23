class Party < ActiveRecord::Base
  belongs_to :matter
  belongs_to :attorney
  has_one :name, as: :nameable
  has_one :address, as: :addressable

  accepts_nested_attributes_for :address, :attorney, :name

  validates :name, presence: true
  validates :attorney_id, presence: true

  def attorney_attributes=(attributes)
    name_digest = Attorney.digest_for(attributes['name'])
    unless attorney = Attorney.find_by(name_digest: name_digest)
      attorney = Attorney.create(attributes)
    end
    self.attorney = attorney
  end

  def name_attributes=(attributes)
    unless name = Name.find_by(first: attributes[:first], middle: attributes[:middle], last: attributes[:last], suffix: attributes[:suffix])
      name = Name.create(attributes)
    end
    self.name = name
  end
end
