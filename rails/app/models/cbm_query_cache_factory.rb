class CbmQueryCacheFactory

  attr_reader :query, :cache

  def initialize(data)
    # hash = HashWithIndifferentAccess.new(data)
    # @query = QueryClass.new(hash)
    # @cache = CacheClass.find_or_create_by(hash)
    raise NotImplementedError.new("Must implement initialize method instantiating @query @cache")
  end

  def run
    find_or_create
  end

  def needs_update?
    return true if query.content_length != cache.content_length
    return true if query.md5 != cache.md5
    return false
  end

  private

  def find_or_create
    if needs_update?
      return create
    else
      return cache
    end
  end

  def create
    cache.content_length = query.content_length
    cache.md5 = query.md5
    if save
      return cache
    else
      return nil
    end
  end

  def save
    if cache.save
      return true
    else
      return false
    end
  end

end

