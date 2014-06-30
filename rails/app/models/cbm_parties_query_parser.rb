class CbmPartiesQueryParser < CbmQueryParser

  def initialize(data)
    @factory = CbmPartiesFactory.new(data)
  end

  def parties
    @parties ||= struct.root['party']
  end

  def md5
    Digest::MD5.hexdigest(parties.inspect)
  end

  private

  def clean_doc
    doc = Nokogiri::XML(factory.run.body)
    doc.search('//text()').each do |t|
      t.replace(t.content.strip.squeeze(' '))
    end
    return doc
  end

end
