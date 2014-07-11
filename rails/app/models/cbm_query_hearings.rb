class CbmQueryHearings < CbmQuery

  attr_reader :court_code, :department, :date

  def initialize(data)
    hash = HashWithIndifferentAccess.new(data)
    @court_code = (hash.fetch(:court_code) { 'F' }).upcase.strip
    @date = (hash.fetch(:date) { Date.today.strftime('%Y%m%d') }).upcase.strip
    @department = hash.fetch(:department).upcase.strip
  end

  def attributes
    HashWithIndifferentAccess.new(
      court_code: court_code,
      date: date,
      department: department
    )
  end

  private

  def build_uri
    "http://riv-dev1/confidentialbenchmemo/api/v1/hearings.aspx?cc=#{court_code}&dept=#{department}&date=#{date}"
  end

end
