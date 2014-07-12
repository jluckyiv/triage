class CbmQueryCacheValidator

  attr_reader :query, :cache

  def initialize(data)
    # hash = HashWithIndifferentAccess.new(data)
    # @query = Query.new(hash)
    # @cache = Cache.find_or_create_by(hash)
    raise NotImplementedError.new("Must implement initialize method instantiating @query @cache")
  end

  def run
    if valid?
      return true
    else
      save
      return false
    end
  end

  private

  def valid?
    return false if query.content_length != cache.content_length
    return false if query.md5 != cache.md5
    return true
  end

  def save
    cache.content_length = query.content_length
    cache.md5 = query.md5
    cache.save
  end

end

