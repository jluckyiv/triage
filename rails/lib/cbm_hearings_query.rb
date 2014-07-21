class CbmHearingsQuery

  class << self

    def run(query_params = {})
      CbmHearingsQuery.new.run(query_params)
    end
  end

  attr_accessor :cc, :date, :time, :departments

  def run(query_params = {})
    @cc = query_params[:cc] || "F"
    @date = query_params[:date] || Date.today.strftime("%Y%m%d")
    @time = query_params[:time] || "8.15"
    @departments = query_params[:dept] || %w[F201 F301 F401 F402']
    hearings_for_departments
  end

  private

  def hearings_for_departments
    Array.wrap(QueryManager.instance.run(uris)).map {|response|
      response.response_body
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
end
