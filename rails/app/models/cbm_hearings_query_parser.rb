class CbmHearingsQueryParser < CbmQueryParser

  def initialize(data)
    @factory = CbmHearingsFactory.new(data)
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
