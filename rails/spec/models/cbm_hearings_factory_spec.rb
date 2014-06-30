require 'spec_helper'

describe CbmHearingsFactory do

  subject { CbmHearingsFactory.new(department: "F501") }
  it { should respond_to :run }
  it { should respond_to :needs_update? }

  context "with valid data" do
    it "should not duplicate the same query" do
      VCR.use_cassette('20140630_F401') do
        f1 = CbmHearingsFactory.new(court_code: "F", date: "20140630", department: "F401")
        run1 = f1.run
        f2 = CbmHearingsFactory.new(date: "20140630", department: "F401")
        run2 = f2.run
        expect(run1.md5).to eq("274d7d56ca4e7ca64ed8d29640b1fd9e")
        expect(run2.md5).to eq("274d7d56ca4e7ca64ed8d29640b1fd9e")
        expect(run1.id).to eq(run2.id)
        expect(run1.instance_of?(CbmHearingsQueryCache)).to be_true
        expect(run2.instance_of?(CbmHearingsQueryCache)).to be_true
        expect(run1).to eq(run2)
      end
    end
  end
end
