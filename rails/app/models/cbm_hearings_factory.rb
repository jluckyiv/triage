class CbmHearingsFactory

  attr_reader :query, :cache

  def initialize(data)
    @cache = CbmHearingsQueryCache.find_or_initialize_by(data)
    @query = CbmHearingsQuery.new(data)
  end

  def needs_update?
    return true if query.content_length != cache.content_length
    # return true if query.md5 != cache.md5
    return false
  end

  def run
    find_or_create
  end

  private

  def find_or_create
    if needs_update?
      return new_cache
    else
      return cache
    end
  end

  def new_cache
    cache.content_length = query.content_length
    cache.md5 = query.md5
    cache.body = query.body
    return save_cache
  end

  def save_cache
    if cache.save
      return cache
    else
      return nil
    end
  end

end

