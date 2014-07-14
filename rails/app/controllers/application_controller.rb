class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  attr_reader :cms_adapter

  def name_parser
    People::NameParser.new
  end

  def cms_adapter
    @cms_adapter = Cbm::Adapter.new
  end

  def cbm_query_result(uri)
    uris = Array.wrap(uri).first
    cbm_query_results(uris).first
  end

  def cbm_query_results(uris)
    hydra = Typhoeus::Hydra.hydra

    list = Array.wrap(uris).each_with_object([]) {|uri, list|
      req = Typhoeus::Request.new(URI.parse(uri))
      req.on_complete do |res|
        list << hash_for_response(res)
      end
      hydra.queue(req)
    }

    hydra.run
    return list
  end

  private

  def hash_for_response(res)
    if res.response_code == 200
      success_hash(res)
    else
      error_hash(res)
    end
  end

  def error_hash(res)
    {
      error: true,
      success: false,
      message:"The server at #{res.effective_url} is either unavailable or is not currently accepting requests. Please try again in a few minutes.",
      response_code: res.response_code,
      return_code: res.return_code,
      response_headers: res.response_headers
    }
  end

  def success_hash(res)
    doc = Nokogiri::XML(res.body)
    clean_doc(doc)
    Hash.from_xml(doc.to_s)['root']
  end

  def clean_doc(doc)
    doc.search('//text()').each do |t|
      t.replace(t.content.strip.squeeze(' '))
    end
  end

end
