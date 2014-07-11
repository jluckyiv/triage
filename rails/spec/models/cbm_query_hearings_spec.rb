require 'spec_helper'

describe CbmQueryHearings do
  subject { CbmQueryHearings.new(department: 'F501') }
  it { should respond_to :court_code }
  it { should respond_to :department }
  it { should respond_to :date }
  it { should respond_to :uri }
  it { should respond_to :header }
  it { should respond_to :content }
  it { should respond_to :content_length }
  it { should respond_to :md5 }
  it { should respond_to :attributes }
  it { should respond_to :run }

  it "should default to court_code 'F'" do
    expect(subject.court_code).to eq 'F'
  end

  it "should default to today's date" do
    expect(subject.date).to eq Date.today.strftime('%Y%m%d')
  end

  context "with valid data and department" do
    query = CbmQueryHearings.new(department: "F501", date: "20140630")

    it "should have the right court_code" do
      expect(query.court_code).to eq "F"
    end

    it "should have the right department" do
      expect(query.department).to eq "F501"
    end

    it "should have the right date" do
      expect(query.date).to eq "20140630"
    end

    it "should return the correct uri" do
      uri = "http://riv-dev1/confidentialbenchmemo/api/v1/hearings.aspx?cc=F&dept=F501&date=20140630"
      expect(query.uri).to eq URI.parse(uri)
    end

    it "should have the right header" do
      VCR.use_cassette('20140630_F501') do
        expect(query.header.status).to eq(["200", "OK"])
      end
    end

    it "should have the right content" do
      VCR.use_cassette('20140630_F501') do
        expect(Digest::MD5.hexdigest(query.run)).to eq "055bfebe9625d6a3ee35440201922273"
      end
    end

    it "should return content with 'run'" do
      VCR.use_cassette('20140630_F501') do
        expect(Digest::MD5.hexdigest(query.run)).to eq "055bfebe9625d6a3ee35440201922273"
      end
    end

    it "should have the right content length" do
      VCR.use_cassette('20140630_F501') do
        expect(query.content_length).to eq 7167
      end
    end

    it "should have the right md5" do
      VCR.use_cassette('20140630_F501') do
        expect(query.md5).to eq "055bfebe9625d6a3ee35440201922273"
      end
    end
  end
end
