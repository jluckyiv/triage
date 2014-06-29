require 'spec_helper'

describe CbmHearingsQuery do
  subject { CbmHearingsQuery.new(department: 'F501') }
  it { should respond_to :court_code }
  it { should respond_to :department }
  it { should respond_to :date }
  it { should respond_to :header }
  it { should respond_to :body }
  it { should respond_to :content }
  it { should respond_to :content_length }
  it { should respond_to :md5 }

  it "should default to court_code 'F'" do
    expect(subject.court_code).to eq 'F'
  end

  it "should default to today's date" do
    expect(subject.date).to eq Date.today.strftime('%Y%m%d')
  end

  context "with valid data and department" do
    VCR.use_cassette('20140630_F501') do
      query = CbmHearingsQuery.new(department: "F501", date: "20140630")
      it "should have the right court_code" do
        expect(query.court_code).to eq "F"
      end
      it "should have the right department" do
        expect(query.department).to eq "F501"
      end
      it "should have the right date" do
        expect(query.date).to eq "20140630"
      end
      it "should have the right header" do
        expect(query.header).to eq {}
      end
      it "should have the right content" do
        expect(query.content).to eq ""
      end
      it "should have the right content length" do
        expect(query.content_length).to eq 0
      end
      it "should have the right md5" do
        expect(query.md5).to eq ""
      end
    end
  end
end
