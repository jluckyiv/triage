require 'spec_helper'

describe CbmQueryHearingsCacheValidator do

  subject { CbmQueryHearingsCacheValidator.new(department: "F501") }

  it_behaves_like "cache_validator"

  context "with valid data" do

    it "should create a cache" do
      VCR.use_cassette('20140630_F401') do
        expect{CbmQueryHearingsCacheValidator.new(date: "20140630", department: "F401").run}.to change{CbmQueryHearingsCache.count}.from(0).to(1)
      end
    end

    it "should be invalid before first run" do
      VCR.use_cassette('20140630_F401') do
        validator = CbmQueryHearingsCacheValidator.new(date: "20140630", department: "F401")
        expect(validator.run).to be_false
      end
    end

    it "should be valid after first run" do
      VCR.use_cassette('20140630_F401') do
        validator = CbmQueryHearingsCacheValidator.new(date: "20140630", department: "F401")
        validator.run
        expect(validator.run).to be_true
      end
    end

    context "with second validator" do
      it "should be valid after first run" do
      VCR.use_cassette('20140630_F401') do
          validator = CbmQueryHearingsCacheValidator.new(date: "20140630", department: "F401")
          validator.run
          expect(CbmQueryHearingsCacheValidator.new(date: "20140630", department: "F401").run).to be_true
        end
      end
    end

    it "should not duplicate records for the same query" do
      VCR.use_cassette('20140630_F401', allow_playback_repeats: true) do
        CbmQueryHearingsCacheValidator.new(date: "20140630", department: "F401").run
        CbmQueryHearingsCacheValidator.new(date: "20140630", department: "F401").run
        CbmQueryHearingsCacheValidator.new(date: "20140630", department: "F401").run
        expect(CbmQueryHearingsCache.where(md5: "fa12eb52f965c82c34b0a6444621b6e4").count).to be 1
      end
    end
  end
end
