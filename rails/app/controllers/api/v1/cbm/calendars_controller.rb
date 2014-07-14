class Api::V1::Cbm::CalendarsController < ApplicationController
  def index
    @cc          = params[:cc].nil?   ? "F"   : URI.escape(params[:cc])
    @departments = params[:dept].nil? ? []    : Array.wrap(params[:dept])
    @date        = params[:date].nil? ? today : URI.escape(params[:date])
    @time        = params[:time]
    render json: filtered_calendars
  end

  private

  attr_accessor :cc, :departments, :date, :time

  def filtered_calendars
    department_calendars.each do |calendar|
      filter_cases(calendar)
      calendar['cases'].each do |kase|
        add_parties(kase)
      end
    end
  end

  def department_calendars
    Array.wrap(cbm_query_results(department_calendar_uris)).sort {|x,y|
      x['department'] <=> y['department']
    }
  end

  def filter_cases(calendar)
    cases = Array.wrap(calendar.delete('case'))
    calendar['cases'] = cases.delete_if {|kase|
      should_delete?(kase)
    }.sort {|x,y|
      "#{x['type']}#{x['number']}" <=> "#{y['type']}#{y['number']}"
    }
  end

  def add_parties(kase)
    ct = kase['type']
    cn = kase['number']
    uri = "http://riv-dev1/confidentialbenchmemo/api/v1/parties.aspx?cc=#{cc}&ct=#{ct}&cn=#{cn}"
    hash = cbm_result(uri)
    kase['parties'] = Array.wrap(hash['party'])
  end

  def should_delete?(kase)
    empty?(kase) || at_wrong_time?(kase)
  end

  def empty?(kase)
    kase.empty? || kase.inspect.strip == "NOTHING"
  end

  def at_wrong_time?(kase)
    time && Array.wrap(kase['hearing']).all? {|hearing|
      hearing['time'] != time
    }
  end

  def today
    Date.today.strftime("%Y%m%d")
  end

  def department_calendar_uris
    departments.each_with_object([]) { |dept, list|
      list << "http://riv-dev1/confidentialbenchmemo/api/v1/hearings.aspx?cc=#{cc}&dept=#{dept}&date=#{date}"
    }
  end

end
