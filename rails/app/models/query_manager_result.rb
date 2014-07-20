class QueryManagerResult

  attr_reader :headers_hash, :response_body, :response_code, :return_code

  class << self
    def with_typhoeus_response(response)
      QueryManagerResult.new({
        headers_hash: response.headers_hash,
        response_body: response.response_body,
        response_code: response.response_code,
        return_code:   response.return_code
      })
    end
  end

  def initialize(hash = {})
    @headers_hash = hash.fetch(:headers_hash) { nil }
    @response_body = hash.fetch(:response_body) { nil }
    @response_code = hash.fetch(:response_code) { nil }
    @return_code = hash.fetch(:return_code) { nil }
  end
end
