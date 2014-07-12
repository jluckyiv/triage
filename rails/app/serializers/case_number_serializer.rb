class CaseNumberSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :case_number

  has_many :matters

  def case_number
    object.full_case_number
  end

end
