require 'spec_helper'

describe CbmPartiesFactory do

  subject { CbmPartiesFactory.new(case_number: "1203066") }

  it { should respond_to :run }

  context "with Indio case" do

    it "should return parties" do
      VCR.use_cassette('IND087055', allow_playback_repeats: true) do
        factory = CbmPartiesFactory.new(court_code: "G", case_type: "IND", case_number: "087055")
        expect(factory.run).to eq Party.where(case_number: factory.case_number)
      end
    end

    it "should create parties" do
      VCR.use_cassette('IND087055', allow_playback_repeats: true) do
        factory = CbmPartiesFactory.new(court_code: "G", case_type: "IND", case_number: "087055")
        expect{factory.run}.to change{Party.count}.from(0).to(13)
      end
    end
  end

  context "with Riverside case" do
    it "should return parties" do
      VCR.use_cassette('RID1203066', allow_playback_repeats: true) do
        factory = CbmPartiesFactory.new(court_code: "F", case_type: "RID", case_number: "1203066")
        expect(factory.run).to eq Party.where(case_number: factory.case_number)
      end
    end

    it "should create parties" do
      VCR.use_cassette('RID1203066') do
        factory = CbmPartiesFactory.new(court_code: "F", case_type: "RID", case_number: "1203066")
        expect{factory.run}.to change{Party.count}.from(0).to(3)
      end
    end

    it "should not recreate parties" do
      VCR.use_cassette('RID1203066', allow_playback_repeats: true) do
        expect{CbmPartiesFactory.new(court_code: "F", case_type: "RID", case_number: "1203066").run}.to change{Party.count}.from(0).to(3)
        expect{CbmPartiesFactory.new(case_type: "RID", case_number: "1203066").run}.not_to change{Party.count}.from(3).to(6)
      end
    end

  end
end
