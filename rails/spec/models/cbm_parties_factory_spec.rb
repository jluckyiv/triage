require 'spec_helper'

describe CbmPartiesFactory do

  subject { CbmPartiesFactory.new(case_number: "1203066") }
  it { should respond_to :run }
  it { should respond_to :needs_update? }

  context "with valid data" do
    it "should not duplicate the same query" do
      VCR.use_cassette('RID1203066') do
        f1 = CbmPartiesFactory.new(court_code: "F", case_type: "RID", case_number: "1203066")
        run1 = f1.run
        f2 = CbmPartiesFactory.new(case_type: "RID", case_number: "1203066")
        run2 = f2.run
        f3 = CbmPartiesFactory.new(case_number: "1203066")
        run3 = f3.run
        expect(run1.md5).to eq("655476107510e41f77725027371d978e")
        expect(run2.md5).to eq("655476107510e41f77725027371d978e")
        expect(run3.md5).to eq("655476107510e41f77725027371d978e")
        expect(run1.id).to eq(run2.id)
        expect(run2.id).to eq(run3.id)
        expect(run1.instance_of?(CbmPartiesQueryCache)).to be_true
        expect(run2.instance_of?(CbmPartiesQueryCache)).to be_true
        expect(run3.instance_of?(CbmPartiesQueryCache)).to be_true
        expect(run1).to eq(run2)
        expect(run2).to eq(run3)
      end
    end
  end

end
