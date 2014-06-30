require 'spec_helper'

describe CbmPartiesQueryParser do
  subject { CbmPartiesQueryParser.new(court_code: "G", case_type: "IND", case_number: "087055") }
  it { should respond_to :parse }
  it { should respond_to :hash }
  it { should respond_to :json }
  it { should respond_to :nokogiri_doc }
  it { should respond_to :struct }
  it { should respond_to :parties }

  context "with valid case information" do
    parser = CbmPartiesQueryParser.new(court_code: "G", case_type: "IND", case_number: "087055")

    it "should parse correctly" do
      VCR.use_cassette('IND087055') do
        expect(Digest::MD5.hexdigest(parser.parse.inspect)).to eq "8cf30a84d96440a93401d436b0f208be"
      end
    end
    it "it should have the correct json" do
      VCR.use_cassette('IND087055') do
        expect(Digest::MD5.hexdigest(parser.json)).to eq "a5ea2db6b0c939e56db9d3ff65cb7259"
      end
    end
    it "should have the right nokogiri_doc" do
      VCR.use_cassette('IND087055') do
        expect(Digest::MD5.hexdigest(parser.nokogiri_doc)).to eq "98fcc8ac062a8dfa7112796c8252fbaf"
      end
    end
    it "should have the right struct" do
      VCR.use_cassette('IND087055') do
        expect(Digest::MD5.hexdigest(parser.struct.inspect)).to eq "2d96e59ab0fe510fd31252fd4f115df3"
      end
    end
  end
end

