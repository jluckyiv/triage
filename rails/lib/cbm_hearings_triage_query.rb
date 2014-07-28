class CbmHearingsTriageQuery

  class << self

    def where(date: Date.today.strftime("%Y%m%d"))
      find(date)
    end

    def find(id)
      calendars = CbmHearingsQuery.where(date: id, dept: %w[F201 F301 F401 F402])
      Array.wrap(calendars).each do |calendar|
        calendar['case'] = matters_for_calendar(calendar.delete('case'))
      end
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
