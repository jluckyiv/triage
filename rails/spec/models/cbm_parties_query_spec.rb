require 'spec_helper'

describe CbmPartiesQuery do
  subject { CbmPartiesQuery.new(case_number: '1203066') }
  it { should respond_to :court_code }
  it { should respond_to :case_type }
  it { should respond_to :case_number }
  it { should respond_to :header }
  it { should respond_to :body }
  it { should respond_to :content }
  it { should respond_to :content_length }
  it { should respond_to :md5 }
  it { should respond_to :to_h }

  it "should default to court_code 'F'" do
    expect(subject.court_code).to eq 'F'
  end

  it "should default to case_type 'RID'" do
    expect(subject.case_type).to eq 'RID'
  end

  context "with valid data and department" do
    query =  CbmPartiesQuery.new(court_code: 'G', case_type: 'IND', case_number: '087055')
    it "should have the right hash" do
      expect(query.to_h).to eq({court_code: 'G', case_type: 'IND', case_number: '087055'})
    end
    it "should have the right court_code" do
      VCR.use_cassette('IND087055') do
        expect(query.court_code).to eq "G"
      end
    end
    it "should have the right case_type" do
      VCR.use_cassette('IND087055') do
        expect(query.case_type).to eq "IND"
      end
    end
    it "should have the right case_number" do
      VCR.use_cassette('IND087055') do
        expect(query.case_number).to eq "087055"
      end
    end
    it "should have the right header" do
      VCR.use_cassette('IND087055') do
        expect(query.header.status).to eq(["200", "OK"])
      end
    end
    it "should have the right content length" do
      VCR.use_cassette('IND087055') do
        expect(query.content_length).to eq 7750
      end
    end
    it "should have the right md5" do
      VCR.use_cassette('IND087055') do
        expect(query.md5).to eq "778009ec7a19156f2b8d6817368bf476"
      end
    end
  end
end

