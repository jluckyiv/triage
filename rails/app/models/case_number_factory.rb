class CaseNumberFactory


  def initialize(data = {})
    hash = HashWithIndifferentAccess.new(data)
    @case_number = hash.fetch(:case_number)
    @case_type = (hash.fetch(:case_type) { "RID" }).upcase
    @court_code = (hash.fetch(:court_code) { "F" }).upcase
  end

  def run
    CaseNumber.find_or_create_by({
      case_number: case_number,
      case_type:   case_type,
      court_code:  court_code
    })
  end

  private

  attr_accessor :case_number, :case_type, :court_code

end
