class Api::V1::Cbm::CalendarsController < ApplicationController
  def index
    @departments = params[:dept].nil? ? [] : Array.wrap(params[:dept])
    @date = params[:date].nil? ? Date.today.strftime("%Y%m%d") : URI.escape(params[:date])
    @cc   = params[:cc].nil? ? "F" : URI.escape(params[:cc])
    calendar_list.each do |calendar|
      case_list(calendar).each do |kase|
        next if kase.include?("NOTHING")
        kase['party'] = parties_for(kase)
      end
    end
    render json: calendar_list
  end

  private

  attr_accessor :departments, :date, :cc

  def calendar_list
    @calendar_list ||= Array.wrap(list_from_uris(uri_list))
  end

  def case_list(calendar)
      Array.wrap(calendar['case'])
  end

  def parties_for(kase)
        ct = kase['type']
        cn = kase['number']
        uri = "http://riv-dev1/confidentialbenchmemo/api/v1/parties.aspx?cc=#{cc}&ct=#{ct}&cn=#{cn}"
        hash = list_from_uris(uri).first
        hash['party']
  end

  def uri_list
    departments.each_with_object([]) { |dept, list|
      list << "http://riv-dev1/confidentialbenchmemo/api/v1/hearings.aspx?cc=#{cc}&dept=#{dept}&date=#{date}"
    }
  end
end
