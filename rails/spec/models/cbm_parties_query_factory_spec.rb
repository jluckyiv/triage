require 'spec_helper'

describe CbmPartiesQueryFactory do

  it_behaves_like "cache_factory"

  subject { CbmPartiesQueryFactory.new(case_number: "1203066") }
  it { should respond_to :run }

  context "with valid data" do
    it "should not duplicate the same query" do
      VCR.use_cassette('RID1203066', allow_playback_repeats: true) do
        CbmPartiesQueryFactory.new(court_code: "F", case_type: "RID", case_number: "1203066").run
        CbmPartiesQueryFactory.new(case_type: "RID", case_number: "1203066").run
        CbmPartiesQueryFactory.new(case_number: "1203066").run
        expect(CbmPartiesQueryCache.where(md5: "655476107510e41f77725027371d978e").count).to be 1
      end
    end
  end

end
