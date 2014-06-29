class CbmPartiesQueryParser
  require 'nokogiri'

  attr_reader :factory, :doc

  def initialize(data)
    @factory = CbmPartiesFactory.new(data)
  end

  def parse
    Hash.from_xml(doc.to_s)
  end
  alias_method :hash, :parse

  def json
    hash.to_json
  end

  def nokogiri_doc
    doc
  end

  def struct
    OpenStruct.new(hash)
  end

  private

  def clean_doc
    doc = Nokogiri::XML(factory.run.body)
    doc.search('//text()').each do |t|
      t.replace(t.content.strip.squeeze(' '))
    end
    return doc
  end

  def doc
    @doc ||= clean_doc
  end
end
