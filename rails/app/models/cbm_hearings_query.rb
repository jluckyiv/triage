class CbmHearingsQuery
  require 'open-uri'

  attr_reader :court_code, :department, :date

  def initialize(data)
    @court_code = (data.fetch(:court_code) { 'F' }).upcase.strip
    @date = (data.fetch(:date) { Date.today.strftime('%Y%m%d') }).upcase.strip
    @department = data.fetch(:department).upcase.strip
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
    "http://riv-dev1/confidentialbenchmemo/api/v1/hearings.aspx?cc=#{court_code}&dept=#{department}&date=#{date}"
  end

end
