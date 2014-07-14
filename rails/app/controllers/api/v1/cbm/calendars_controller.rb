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
    hash = cbm_query_result(uri)
    kase['parties'] = Array.wrap(hash['party'])
  end

  # def add_parties(kase)
  #   return if empty?(kase)
  #   ct = kase['type']
  #   cn = kase['number']
  #   unless case_number = CaseNumber.find_by(court_code: cc, case_type: ct, case_number: cn)
  #     uri = "http://riv-dev1/confidentialbenchmemo/api/v1/parties.aspx?cc=#{cc}&ct=#{ct}&cn=#{cn}"
  #     parties_hashes = Array.wrap(cbm_query_result(uri)['party'])
  #     case_number = CaseNumber.create(court_code: cc, case_type: ct, case_number: cn)
  #     parties_hashes.each do |hash|
  #       next if empty?(hash)
  #       hash['role'] = hash.delete('type') if hash.has_key?('type')
  #       hash['dob'] = Chronic.parse(hash.delete('dob')) if hash.has_key?('dob')
  #       hash['address_attributes'] = hash.delete('address') if hash.has_key?('address')
  #       if hash.has_key?('name')
  #         hash['name_attributes'] = hash.delete('name')
  #         hash['name_attributes'].delete('full')
  #       end
  #       if hash.has_key?('attorney')
  #         hash['attorney']['address_attributes'] = hash['attorney'].delete('address')
  #         hash['attorney_attributes'] = hash.delete('attorney')
  #       end
  #       case_number.parties.create(hash)
  #     end
  #   end
  #   kase['parties'] = case_number.parties
  # end

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
