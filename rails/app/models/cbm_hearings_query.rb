class CbmHearingsQuery < CbmQuery

  attr_reader :court_code, :department, :date

  def initialize(data)
    @court_code = (data.fetch(:court_code) { 'F' }).upcase.strip
    @date = (data.fetch(:date) { Date.today.strftime('%Y%m%d') }).upcase.strip
    @department = data.fetch(:department).upcase.strip
  end

  def attributes
    {
      court_code: court_code,
      date: date,
      department: department
    }
  end

  private

  def build_uri
    "http://riv-dev1/confidentialbenchmemo/api/v1/hearings.aspx?cc=#{court_code}&dept=#{department}&date=#{date}"
  end

end
