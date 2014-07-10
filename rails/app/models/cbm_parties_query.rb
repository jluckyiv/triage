class CbmPartiesQuery < CbmQuery

  attr_reader :court_code, :case_type, :case_number

  def initialize(data)
    hash = HashWithIndifferentAccess.new(data)
    @court_code = (hash.fetch(:court_code) { 'F' }).upcase.strip
    @case_type = (hash.fetch(:case_type) { 'RID' }).upcase.strip
    @case_number = hash.fetch(:case_number).upcase.strip
  end

  def attributes
    {
      court_code: court_code,
      case_type: case_type,
      case_number: case_number
    }
  end

  private

  def build_uri
    "http://riv-dev1/confidentialbenchmemo/api/v1/parties.aspx?cc=#{court_code}&ct=#{case_type}&cn=#{case_number}"
  end

end
