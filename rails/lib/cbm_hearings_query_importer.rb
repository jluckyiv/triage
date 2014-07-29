class CbmHearingsQueryImporter

  attr_accessor :court_code, :department, :date

  class << self
    def import(query)
      self.new.import(query)
    end
  end

  def import(query)
    matters = Array.wrap(query).each_with_object([]) { |calendar, list|
      list.concat(create_calendar(calendar))
    }.compact
    CbmPartiesImporter.import(matters)
    matters
  end

  def create_calendar(calendar)
    @court_code = calendar['court_code']
    @date = calendar['date']
    @department = Department.find_by(name: calendar['department'])
    Array.wrap(calendar['case']).map { |matter|
      create_matter(matter)
    }.compact
  end

  def create_matter(matter)
    return if matter.include?('NOTHING')
    matter_hash = {
      'court_code' =>  court_code,
      'case_type' =>   matter['type'],
      'case_number' => matter['number']
    }
    Matter.find_or_create_by(matter_hash) do |m|
      m.proceedings_attributes = proceedings_attributes(matter)
    end
  end

  def proceedings_attributes(matter)
    list = Array.wrap(matter['hearing']).map {|proceeding|
      {
        'description' => proceeding['description'],
        'hearings_attributes' => hearings_attributes(proceeding)
      }
    }
    list.group_by {|p|
      p['description']}.map {|k,v|
        {
          'description' => k,
          'hearings_attributes' => v.map {|h|
            h['hearings_attributes']
          }
        }
      }
  end

  def hearings_attributes(proceeding)
    {
      'interpreter' => proceeding['interpreter'],
      'date_time' => date_time(date, proceeding['time']),
      'department' => department
    }
  end

  def date_time(date, time)
    formatted_time = "%04d" % (time.to_d * 100)
    date_time = "#{date} T #{formatted_time}"
  end
end
