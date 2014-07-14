module Cbm
  class QueryManager

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
        req = Typhoeus::Request.new(URI.parse(uri))
        req.on_complete do |res|
          list << res
        end
        hydra.queue(req)
      }

      hydra.run
      return responses
    end
    alias_method :run_all, :run

    private

      attr_accessor :hydra

  end
end
