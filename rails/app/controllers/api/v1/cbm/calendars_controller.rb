class Api::V1::Cbm::CalendarsController < ApplicationController
  def index
    @departments = params[:dept].nil? ? [] : Array.wrap(params[:dept])
    @date = params[:date].nil? ? Date.today.strftime("%Y%m%d") : URI.escape(params[:date])
    @time = params[:time]
    @cc   = params[:cc].nil? ? "F" : URI.escape(params[:cc])
    render json: calendars
  end

  private

  attr_accessor :cc, :departments, :date, :time

  def calendars
    Array.wrap(cbm_results(uris)).each do |calendar|
      cases(calendar)
    end
  end

  def cases(calendar)
    Array.wrap(cases_for_calendar(calendar)).each do |kase|
      parties(kase)
    end
  end

  def parties(kase)
    Array.wrap(parties_for_case(kase))
  end

  def cases_for_calendar(calendar)
    Array.wrap(calendar['case']).keep_if { |kase|
      valid?(kase)    }
  end

  def valid?(kase)
    has_content?(kase) && has_hearing_at_time?(kase)
  end

  def has_content?(kase)
    kase && kase.exclude?("NOTHING")
  end

  def has_hearing_at_time?(kase)
    time && kase.inspect.include?(time)
  end

  def parties_for_case(kase)
    ct = kase['type']
    cn = kase['number']
    uri = "http://riv-dev1/confidentialbenchmemo/api/v1/parties.aspx?cc=#{cc}&ct=#{ct}&cn=#{cn}"
    hash = Array.wrap(cbm_results(uri)).first
    kase['party'] = hash['party']
  end

  def uris
    departments.each_with_object([]) { |dept, list|
      list << "http://riv-dev1/confidentialbenchmemo/api/v1/hearings.aspx?cc=#{cc}&dept=#{dept}&date=#{date}"
    }
  end
end
