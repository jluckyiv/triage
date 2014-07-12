class CbmQueryPartiesCacheValidator < CbmQueryCacheValidator

  def initialize(data)
    hash = HashWithIndifferentAccess.new(data)
    @query = CbmQueryParties.new(hash)
    @cache = CbmQueryPartiesCache.find_or_create_by(hash)
  end

end

