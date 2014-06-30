class CbmPartiesFactory < CbmFactory

  delegate :court_code, :case_type, :case_number, to: :query
  def initialize(data)
    @query = CbmPartiesQuery.new(data)
    @cache = CbmPartiesQueryCache.find_or_create_by(query.to_h)
  end

end

