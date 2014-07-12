require 'spec_helper'

describe CbmQueryPartiesCacheValidator do

  it_behaves_like "cache_validator"

  subject { CbmQueryPartiesCacheValidator.new(case_number: "1203066") }

  context "with valid data" do

    it "should create a cache" do
      VCR.use_cassette('RID1203066', allow_playback_repeats: true) do
        expect{CbmQueryPartiesCacheValidator.new(case_type: "RID", case_number: "1203066").run}.to change{CbmQueryPartiesCache.count}.from(0).to(1)
      end
    end

    it "should need update before first run" do
      VCR.use_cassette('RID1203066', allow_playback_repeats: true) do
        validator = CbmQueryPartiesCacheValidator.new(case_type: "RID", case_number: "1203066")
        expect(validator.run).to be_false
      end
    end

    it "should not need update after first run" do
      VCR.use_cassette('RID1203066', allow_playback_repeats: true) do
        validator = CbmQueryPartiesCacheValidator.new(case_type: "RID", case_number: "1203066")
        validator.run
        expect(validator.run).to be_true
      end
    end

    context "with second validator" do
      it "should not need update after first run" do
        VCR.use_cassette('RID1203066', allow_playback_repeats: true) do
          validator = CbmQueryPartiesCacheValidator.new(case_type: "RID", case_number: "1203066")
          validator.run
          expect(CbmQueryPartiesCacheValidator.new(case_type: "RID", case_number: "1203066").run).to be_true
        end
      end
    end

    it "should not duplicate records for the same query" do
      VCR.use_cassette('RID1203066', allow_playback_repeats: true) do
        CbmQueryPartiesCacheValidator.new(court_code: "F", case_type: "RID", case_number: "1203066").run
        CbmQueryPartiesCacheValidator.new(case_type: "RID", case_number: "1203066").run
        CbmQueryPartiesCacheValidator.new(case_number: "1203066").run
        expect(CbmQueryPartiesCache.where(md5: "655476107510e41f77725027371d978e").count).to be 1
      end
    end
  end

end
