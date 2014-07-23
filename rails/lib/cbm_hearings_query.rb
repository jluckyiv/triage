class CbmHearingsQuery

  require 'nokogiri'

  class << self

    def where(query_params = {})
      CbmHearingsQuery.new.where(query_params)
    end

    def find(date)
      CbmHearingsQuery.new.where(date: date)
    end
  end

  attr_accessor :cc, :date, :time, :departments

  def where(query_params = {})
    @cc = query_params[:cc] || "F"
    @date = query_params[:date] || Date.today.strftime("%Y%m%d")
    @time = query_params[:time] || "8.15"
    @departments = query_params[:dept] || %w[F201 F301 F401 F402']
    hearings_for_departments
  end

  private

  def hearings_for_departments
    Array.wrap(QueryManager.instance.run(uris)).map {|response|
      hash_from_response(response)
    }
  end

  def uris
    Array.wrap(departments).map {|dept|
      uri(dept)
    }
  end

  def uri(dept)
    URI.join(
      Triage::Application.config.cbm_uri,
      "hearings.aspx?cc=#{cc}&date=#{date}&dept=#{dept}"
    )
  end

  def hash_from_response(response)
    doc = Nokogiri::XML(response.response_body)
    doc.search('//text()').each do |t|
      t.replace(t.content.strip)
    end
    Hash.from_xml(doc.to_s)['root']
  end
end
