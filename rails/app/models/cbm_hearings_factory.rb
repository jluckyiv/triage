class CbmHearingsFactory < CbmFactory

  def initialize(data)
    @query = CbmHearingsQuery.new(data)
    @cache = CbmHearingsQueryCache.find_or_create_by(query.to_h)
  end

end

