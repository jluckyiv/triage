class CbmHearingsQueryParser < CbmQueryParser

  def initialize(data)
    hash = HashWithIndifferentAccess.new(data)
    @query = CbmHearingsQuery.new(hash)
  end

  def run
    cases
  end

  def md5
    Digest::MD5.hexdigest(cases.inspect)
  end

  private

  def cases
    @cases ||= struct.root['case']
  end

  def clean_doc
    doc = Nokogiri::XML(query.content)
    doc.search('//text()').each do |t|
      t.replace(t.content.strip.squeeze(' ').gsub(/Orderon/, "Order on"))
    end
    return doc
  end

end
