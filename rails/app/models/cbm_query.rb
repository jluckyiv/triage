class CbmQuery
  require 'open-uri'

  def initialize(data)
    raise NotImplementedError.new("Must implement #initialize(data = {}) method")
  end

  def attributes
    raise NotImplementedError.new("Must implement #attributes method")
  end

  def header
    @header ||= open_uri
  end

  def content
    @content ||= header.read
  end
  alias_method :run, :content

  def content_length
    @content_length = header.meta.fetch("content-length").to_i { 0 }
  end

  def md5
    @md5 ||= Digest::MD5.hexdigest(content)
  end

  def uri
    URI.parse(build_uri)
  end

  private

  attr_accessor :timeouts

  def build_uri
    raise NotImplementedError.new("Must implement #build_uri method")
  end

  def open_uri
    begin
      doc = open(uri)
    rescue Timeout::Error
      sleep(1)
      doc = open(uri)
    end
  end

end
