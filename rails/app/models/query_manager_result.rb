class QueryManagerResult

  attr_reader :response_body, :response_code, :response_headers, :return_code

  def initialize(hash = {})
    @response_body = hash.fetch(:response_body) { nil }
    @response_code = hash.fetch(:response_code) { nil }
    @response_headers = hash.fetch(:response_headers) { nil }
    @return_code = hash.fetch(:return_code) { nil }
  end
end
