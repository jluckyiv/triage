class CbmQueryParser
  require 'nokogiri'

  def initialize(data)
    # @factory = CbmHearingsFactory.new(data)
    raise NotImplementedError.new("Need .initialize(data) assigning an instance of a CbmFactory class")
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

  attr_reader :factory

  def clean_doc
    # doc = Nokogiri::XML(factory.run.body)
    raise NotImplementedError.new("Need .clean_doc returning Nokogiri::XML(factory.run.body)")
  end

  def doc
    @doc ||= clean_doc
  end
end
