class CbmQueryFactory

  attr_reader :query, :cache

  def initialize(data)
    raise NotImplementedError.new("Must implement initialize method")
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
      return new_cache
    else
      return cache
    end
  end

  def new_cache
    cache.content_length = query.content_length
    cache.md5 = query.md5
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

