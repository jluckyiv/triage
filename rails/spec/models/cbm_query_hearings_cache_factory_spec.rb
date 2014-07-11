require 'spec_helper'

describe CbmQueryHearingsCacheFactory do

  subject { CbmQueryHearingsCacheFactory.new(department: "F501") }

  it_behaves_like "cache_factory"

  context "with valid data" do

    it "should create a cache" do
      VCR.use_cassette('20140630_F401') do
        expect{CbmQueryHearingsCacheFactory.new(date: "20140630", department: "F401").run}.to change{CbmQueryHearingsCache.count}.from(0).to(1)
      end
    end

    it "should not need an update for a duplicate query" do
      VCR.use_cassette('20140630_F401') do
        factory1 = CbmQueryHearingsCacheFactory.new(court_code: "F", date: "20140630", department: "F401")
        factory1.run
        factory2 = CbmQueryHearingsCacheFactory.new(date: "20140630", department: "F401")
        expect(factory2.needs_update?).to be_false
      end
    end

    it "should not create a duplicate cache" do
      VCR.use_cassette('20140630_F401') do
        factory1 = CbmQueryHearingsCacheFactory.new(court_code: "F", date: "20140630", department: "F401")
        factory1.run
        factory2 = CbmQueryHearingsCacheFactory.new(date: "20140630", department: "F401")
        expect{factory2.run}.not_to change{CbmQueryHearingsCache.count}.from(1).to(2)
      end
    end

    it "should not duplicate the same query" do
      VCR.use_cassette('20140630_F401') do
        run1 = CbmQueryHearingsCacheFactory.new(court_code: "F", date: "20140630", department: "F401").run
        run2 = CbmQueryHearingsCacheFactory.new(date: "20140630", department: "F401").run
        expect(run1.id).to eq run2.id
      end
    end
  end
end
