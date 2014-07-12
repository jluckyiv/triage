class CbmQueryPartiesParser < CbmQueryParser

  def initialize(data)
    hash = HashWithIndifferentAccess.new(data)
    @query = CbmQueryParties.new(hash)
  end

  def run
    parties
  end

  def md5
    Digest::MD5.hexdigest(parties.inspect)
  end

  private

  def parties
    @parties ||= struct.root['party']
  end

  def clean_doc
    doc = Nokogiri::XML(query.content)
    doc.search('//text()').each do |t|
      t.replace(t.content.strip.squeeze(' '))
    end
    return doc
  end

end
