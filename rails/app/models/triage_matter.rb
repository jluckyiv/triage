class TriageMatter

  class << self
    def find(id)
      query = CbmHearingsTriageQuery.where(date: id)
      CbmHearingsQueryImporter.import(query)
    end

    def where(date: Date.today.strftime("%Y%m%d"))
      find(date)
    end

    def matters_for_calendar(cases)
      Array.wrap(cases).select {|kase|
        has_triage_hearing(kase)
      }
    end

    def has_triage_hearing(kase)
      has_hearing_at_time(kase, '8.15')
    end

    def has_hearing_at_time(kase, time)
      Array.wrap(kase['hearing']).any? {|hearing|
        hearing['time'].include?(time)
      }
    end
  end
end
