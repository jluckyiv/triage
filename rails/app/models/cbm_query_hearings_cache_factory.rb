class CbmQueryHearingsCacheFactory < CbmQueryCacheFactory

  def initialize(data)
    hash = HashWithIndifferentAccess.new(data)
    @query = CbmQueryHearings.new(hash)
    @cache = CbmQueryHearingsCache.find_or_create_by(hash)
  end

end

