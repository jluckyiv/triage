class CbmPartiesQueryFactory < CbmQueryFactory

  def initialize(data)
    @query = CbmPartiesQuery.new(data)
    @cache = CbmPartiesQueryCache.find_or_create_by(data)
  end

end

