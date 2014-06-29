class CbmPartiesQueryParser < CbmQueryParser

  def initialize(data)
    @factory = CbmPartiesFactory.new(data)
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
