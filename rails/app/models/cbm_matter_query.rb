class CbmMatterQuery

  class << self
    def find_all(case_numbers)
      responses = QueryManager.instance.run(uris_for(case_numbers))
      matters_for(responses)
    end

    def find(case_number)
      response = QueryManager.instance.run_once(uri_for(case_number))
      matters_for(response).first
    end

    private

    def uris_for(case_numbers)
      uris = Array.wrap(case_numbers).each_with_object([]) do |case_number, list|
        list << uri_for(case_number)
      end
    end

    def uri_for(case_number)
      case_number = CaseNumberParser.parse(case_number)
      URI.join(
        Triage::Application.config.cbm_uri,
        "parties.aspx?cc=#{case_number[:court_code]}&ct=#{case_number[:case_type]}&cn=#{case_number[:case_number]}"
      )
    end

    def matters_for(responses)
      matters = Array.wrap(responses).each_with_object([]) do |response, list|
        list << hash_for(response.response_body)
      end
    end

    def hash_for(body)
      hash = raw_hash(body)
      hash['parties_attributes'] = parties_attributes(hash)
      hash
    end

    def parties_attributes(data)
      parties_attributes = data.delete('party')
      Array.wrap(parties_attributes).each do |party|
        party['role'] = party.delete('type')
        create_nested_attribute(party, 'name')
        create_nested_attribute(party, 'address')
        create_nested_attribute(party, 'attorney')
        create_nested_attribute(party['attorney_attributes'], 'address')
        party['name_attributes'].delete('full')
        party.delete('dob') if party['dob'].gsub(/\D/, '').to_i == 0
        party['dob'] = Chronic.parse(party.delete('dob'))
      end
    end

    def create_nested_attribute(hash, old_key)
      new_key = "#{old_key}_attributes".underscore
      rename_key(hash, old_key, new_key)
    end

    def rename_key(hash, old_key, new_key)
      hash[new_key] = hash.delete(old_key)
    end

    def raw_hash(body)
      begin
        doc = Nokogiri::XML(body)
        clean_doc(doc)
        Hash.from_xml(doc.to_s)['root']
      rescue REXML::ParseException
        return {}
      end
    end

    def clean_doc(doc)
      Array.wrap(doc.search('//text()')).each do |t|
        t.replace(t.content.strip.squeeze(' '))
      end
    end

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
      # doc = Nokogiri::XML(res.body)
      # clean_doc(doc)
      # Hash.from_xml(doc.to_s)['root']
    end

  end
end
