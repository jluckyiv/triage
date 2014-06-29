class CbmPartiesQuery
  require 'open-uri'

  attr_reader :court_code, :case_type, :case_number

  def initialize(data)
    @court_code = (data.fetch(:court_code) { 'F' }).upcase.strip
    @case_type = (data.fetch(:case_type) { 'RID' }).upcase.strip
    @case_number = data.fetch(:case_number).upcase.strip
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
    "http://riv-dev1/confidentialbenchmemo/api/v1/parties.aspx?cc=#{court_code}&ct=#{case_type}&cn=#{case_number}"
  end

end
