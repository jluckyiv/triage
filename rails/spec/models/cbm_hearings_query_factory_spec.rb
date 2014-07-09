require 'spec_helper'

describe CbmHearingsQueryFactory do

  subject { CbmHearingsQueryFactory.new(department: "F501") }
  it { should respond_to :run }

  context "with valid data" do
    it "should not duplicate the same query" do
      VCR.use_cassette('20140630_F401') do
        run1 = CbmHearingsQueryFactory.new(court_code: "F", date: "20140630", department: "F401").run
        CbmHearingsQueryFactory.new(date: "20140630", department: "F401").run
        expect(CbmHearingsQueryCache.where(md5: run1.md5).count).to be 1
      end
    end
  end
end
