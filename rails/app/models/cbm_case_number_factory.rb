class CbmCaseNumberFactory

  attr_reader :court_code, :case_type, :case_number

  def self.batch_find_or_create_by(objects)
    Array(objects).each_with_object([]) {|obj, list|
      list << Case
    }
  end
  def initialize(data)
    hash = HashWithIndifferentAccess.new(data)
    @court_code = (hash.fetch(:court_code) { "F" }).upcase.strip
    @case_type  = (hash.fetch(:case_type)  { "RID" }).upcase.strip
    @case_number = hash.fetch(:case_number).upcase.strip
  end

  def run
    CaseNumber.find_or_create_by(to_h)
  end

  def to_h
    {
      court_code: court_code,
      case_type:  case_type,
      case_number: case_number
    }
  end
end
