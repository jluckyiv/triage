class CbmHearingsQueryParser < CbmQueryParser

  def initialize(data)
    @factory = CbmHearingsFactory.new(data)
  end

  def cases
    @cases ||= struct.root['case']
  end

  def md5
    Digest::MD5.hexdigest(cases.inspect)
  end

  private

  def clean_doc
    doc = Nokogiri::XML(factory.run.body)
    doc.search('//text()').each do |t|
      t.replace(t.content.strip.squeeze(' ').gsub(/Orderon/, "Order on"))
    end
    return doc
  end

end
