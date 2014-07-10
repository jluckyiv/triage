class CbmHearingsQueryFactory < CbmQueryFactory

  def initialize(data)
    hash = HashWithIndifferentAccess.new(data)
    @query = CbmHearingsQuery.new(hash)
    @cache = CbmHearingsQueryCache.find_or_create_by(hash)
  end

end

