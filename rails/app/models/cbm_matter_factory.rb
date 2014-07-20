class CbmMatterFactory

  class << self

    def find(full_case_number)
      find_all(full_case_number).first
    end

    def find_all(full_case_numbers)
      matters = []
      missing_case_numbers = []

      Array.wrap(full_case_numbers).each do |full_case_number|
        case_number = CaseNumberParser.parse(full_case_number)
        if matter = Matter.find_by(case_number)
          matters << matter
        else
          missing_case_numbers << case_number
        end
      end

      missing_case_numbers.each do |case_number|
        data = CbmMatterQuery.new.find(case_number)
        matters << Matter.create(data)
      end

      matters

    end
  end
end
