class CbmHearingsQueryFactory < CbmQueryFactory

  def initialize(data)
    @query = CbmHearingsQuery.new(data)
    @cache = CbmHearingsQueryCache.find_or_create_by(data)
  end

end

