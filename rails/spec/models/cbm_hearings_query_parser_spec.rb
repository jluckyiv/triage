require 'spec_helper'

describe CbmHearingsQueryParser do
  subject { CbmHearingsQueryParser.new(department: "F501") }
  it { should respond_to :parse }
  it { should respond_to :hash }
  it { should respond_to :json }
  it { should respond_to :nokogiri_doc }
  it { should respond_to :struct }
  it { should respond_to :cases }
  it { should respond_to :md5 }

  context "with valid calendar information" do
    parser = CbmHearingsQueryParser.new(department: "F501", date: "20140630")

    it "should parse correctly" do
      VCR.use_cassette('20140630_F501') do
        expect(Digest::MD5.hexdigest(parser.parse.inspect)).to eq "287df02761ef29536270915f8b197d38"
      end
    end
    it "it should have the correct json" do
      VCR.use_cassette('20140630_F501') do
        expect(Digest::MD5.hexdigest(parser.json)).to eq "dc7fb66909782569dc10d24e9877c544"
      end
    end
    it "should have the right nokogiri_doc" do
      VCR.use_cassette('20140630_F501') do
        expect(Digest::MD5.hexdigest(parser.nokogiri_doc)).to eq "a118e1025ef1b4db56be0c7fcc9f3b53"
      end
    end
    it "should have the right struct" do
      VCR.use_cassette('20140630_F501') do
        expect(Digest::MD5.hexdigest(parser.struct.inspect)).to eq "42e6d5d5d12abd1abae28b64eca8faf5"
      end
    end
  end
end

