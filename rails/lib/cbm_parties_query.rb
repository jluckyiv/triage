class CbmPartiesQuery

  require 'nokogiri'

  class << self

    def where(query_params)
      CbmPartiesQuery.new.where(query_params)
    end

    def find(case_number)
      CbmPartiesQuery.new.find(case_number)
    end
  end

  attr_accessor :case_numbers

  def find(case_number)
    @case_numbers = CaseNumberParser.parse(case_number)
    parties_for_case_numbers
  end

  def where(case_numbers)
    @case_numbers = CaseNumberParser.parse_all(case_numbers[:case_numbers])
    parties_for_case_numbers
  end

  private

  def parties_for_case_numbers
    Array.wrap(QueryManager.instance.run(uris)).map {|response|
      hash_from_response(response)
    }
  end

  def uris
    Array.wrap(case_numbers).map {|case_number|
      uri(case_number)
    }
  end

  def uri(case_number)
    URI.join(
      Triage::Application.config.cbm_uri,
      "parties.aspx?cc=#{case_number[:court_code]}&ct=#{case_number[:case_type]}&cn=#{case_number[:case_number]}"
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
