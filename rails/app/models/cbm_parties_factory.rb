class CbmPartiesFactory < CbmFactory

  def initialize(data)
    @query = CbmPartiesQuery.new(data)
    @cache = CbmPartiesQueryCache.find_or_create_by(query.to_h)
  end

end

