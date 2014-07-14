class CaseNumberParser
  def initialize(case_number, options = {})
    @full_case_number = case_number
    @options = options
  end

  def self.parse(case_number)
    return CaseNumberParser.new(case_number).parse
  end

  def parse
    return {} if invalid?
    {
      court_code: court_code.upcase,
      case_type: case_type.upcase,
      case_number: case_number.upcase
    }
  end

  private

  attr_reader :full_case_number, :options

  def court_code
    options.fetch(:court_code) { default_court_code }
  end

  def default_court_code
    if ind?
      return 'G'
    else
      return 'F'
    end
  end

  def case_number
    full_case_number.sub(case_type, '')
  end

  def invalid?
    case_type.empty?
  end

  def case_type
    case_types.find { |case_type|
      /\A#{case_type}/.match full_case_number
    }.to_s
  end

  def ind_case_types
    %w[BLD BLV IFA INA IND INK INV]
  end

  def riv_case_types
    %w[D DV FAM HEA HEA HEK HEV RIA RID RIK RIV SWD SWV TED TEV]
  end

  def case_types
    Array(riv_case_types + ind_case_types)
  end

  def riv?
    riv_case_types.include?(case_type)
  end

  def ind?
    ind_case_types.include?(case_type)
  end

end
