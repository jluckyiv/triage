require 'singleton'

class QueryManager

  include Singleton

  def initialize
    @hydra ||= Typhoeus::Hydra.new
  end

  def run_once(uri)
    uris = Array.wrap(uri).first
    run(uris).first
  end
  alias_method :run_one, :run_once

  def run(uris)

    responses = Array.wrap(uris).each_with_object([]) {|uri, list|
      req = Typhoeus::Request.new(parsed_uri(uri))
      req.on_complete do |res|
        list << res
      end
      hydra.queue(req)
    }

    hydra.run
    return results_for(responses)
  end
  alias_method :run_all, :run

  private

  attr_accessor :hydra

  def results_for(responses)
    Array.wrap(responses).each_with_object([]) do |response, list|
      list << QueryManagerResult.with_typhoeus_response(response)
    end
  end

  def parsed_uri(uri)
    return uri if uri.is_a? URI
    return URI.parse(uri) if uri.is_a? String
  end

end
