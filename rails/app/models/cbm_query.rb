class CbmQuery
  require 'open-uri'

  def initialize(data)
    raise NotImplementedError.new("Need initialize method taking a hash parameter")
  end

  def header
    @header ||= open(uri)
  end

  def body
    @body ||= header.read
  end
  alias_method :content, :body

  def content_length
    @content_length = header.meta.fetch("content-length").to_i { 0 }
  end

  def md5
    @md5 ||= Digest::MD5.hexdigest(body)
  end

  private

  def uri
    uri = URI.parse(build_uri)
  end

  def build_uri
    raise NotImplementedError.new("Need #build_uri method returning necessary uri")
  end

end
