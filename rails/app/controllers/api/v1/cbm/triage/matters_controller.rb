class Api::V1::Cbm::Triage::MattersController < Api::V1::Cbm::CalendarsController

  def index
    # @date        = params[:date].nil? ? today : URI.escape(params[:date])
    # @time        = "8.15"
    # @departments = %w[F201 F301 F401 F402 F501 F502]
    # @cc          = "F"
    # render json: triage_calendar
    render json: CbmMatterFactory.find_all(params[:case_number])
  end

  def show
    # @date        = params[:id].nil? ? today : URI.escape(params[:id])
    # @time        = "8.15"
    # @departments = %w[F201 F301 F401 F402 F501 F502]
    # @cc          = "F"
    # render json: triage_calendar
    render json: CbmMatterFactory.find(params[:id])
  end

  def triage_calendar
    filtered_calendars.each_with_object([]) { |calendar, list|
      list.concat(triage_entries(calendar))
    }
  end

  def triage_entries(calendar)
    calendar['cases'].each_with_object([]) do |matter, list|
      list << triage_entry(matter, calendar)
    end
  end

end
