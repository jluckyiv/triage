class CaseNumberParser

  def self.parse_all(case_numbers)
    return CaseNumberParser.new.parse_all(case_numbers)
  end

  def self.parse(case_number)
    return CaseNumberParser.new.parse(case_number)
  end

  def parse_all(case_numbers)
    Array.wrap(case_numbers).map {|case_number|
      parse(case_number)
    }
  end

  def parse(input)
    @input = input
    return {} if invalid?
    {
      court_code: URI.escape(court_code.upcase),
      case_type: URI.escape(case_type.upcase),
      case_number: URI.escape(case_number.upcase)
    }
  end

  private

  attr_reader :input

  def court_code
    return input.court_code if input.respond_to?(:court_code)
    HashWithIndifferentAccess.new(input).fetch(:court_code) { default_court_code }
  end

  def case_number
    return input.case_number if input.respond_to?(:case_number)
    return input.sub(case_type, '') if input.respond_to?(:sub)
    HashWithIndifferentAccess.new(input).fetch(:case_number) { "" }
  end

  def case_type
    return input.case_type if input.respond_to?(:case_type)
    HashWithIndifferentAccess.new(input).fetch(:case_type) { default_case_type }
  end

  def default_court_code
    if ind?
      return 'G'
    else
      return 'F'
    end
  end

  def invalid?
    case_type.empty?
  end

  def default_case_type
    case_types.find { |case_type|
      /\A#{case_type}/.match input
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
