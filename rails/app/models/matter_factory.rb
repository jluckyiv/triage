class MatterFactory
  class << self
    def format_time(date, time)
      time = "%04d" % (time.to_i * 100)
      Time.zone.parse("#{date} T #{time}")
    end

    def find_all(department_matters)
      need = []
      have = Array.wrap(department_matters).each_with_object([]) {|kase, list|
        hash = kase.slice('court_code', 'case_type', 'case_number')
        hearings = Array.wrap(kase['hearing']).map {|h|
          {
            department: kase['department'],
            description: h['description'],
            date_time: format_time(kase['date'], h['time'])
          }
        }
        if matter = Matter.find_by(hash)
          matter.hearings.find_or_create_by(hearings)
          list << matter
        else
          need << hash
          Matter.create(hash).hearings.create(hearings)
        end
      }
      have.concat(CbmMatterImporter.import(need))
    end
  end
end
