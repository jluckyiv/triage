class CbmPartiesQueryFactory < CbmQueryFactory

  def initialize(data)
    hash = HashWithIndifferentAccess.new(data)
    @query = CbmPartiesQuery.new(hash)
    @cache = CbmPartiesQueryCache.find_or_create_by(hash)
  end

end

