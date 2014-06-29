class CbmPartiesQuery < CbmQuery

  attr_reader :court_code, :case_type, :case_number

  def initialize(data)
    @court_code = (data.fetch(:court_code) { 'F' }).upcase.strip
    @case_type = (data.fetch(:case_type) { 'RID' }).upcase.strip
    @case_number = data.fetch(:case_number).upcase.strip
  end

  private

  def build_uri
    "http://riv-dev1/confidentialbenchmemo/api/v1/parties.aspx?cc=#{court_code}&ct=#{case_type}&cn=#{case_number}"
  end

end
