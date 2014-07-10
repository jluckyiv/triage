class HearingFactory

  def initialize(data = {})
    hash = HashWithIndifferentAccess.new(data)
    @matter_id = hash.fetch(:matter_id) { nil }
    @description = hash.fetch(:description) { nil }
    @time = hash.fetch(:time) { '8.30' }
  end

  def run
    return nil if description.nil?
    return nil if matter_id.nil?
    Hearing.create_with(description: description).find_or_create_by(params)
  end

  private

  attr_accessor :time, :description, :md5, :matter_id

  def params
    {
      matter_id: matter_id,
      time: time,
      md5:  Digest::MD5.hexdigest(description)
    }
  end
end

