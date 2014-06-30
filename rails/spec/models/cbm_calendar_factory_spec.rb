require 'spec_helper'

describe CbmCalendarFactory do
  it { should respond_to :run }

  context "with a single courtroom" do
    factory = CbmCalendarFactory.new(date: "20140709", time: "8.30", departments: ["F501"])

    it "should increase the number of calendars" do
      VCR.use_cassette('20140709_F501') do
        expect{factory.run}.to change{Calendar.count}.from(0).to(1)
      end
    end

    it "should increase the number of cases" do
      VCR.use_cassette('20140709_F501') do
        expect{factory.run}.to change{CaseNumber.count}.from(0).to(5)
      end
    end

    it "should increase the number of matters" do
      VCR.use_cassette('20140709_F501') do
        expect{factory.run}.to change{Matter.count}.from(0).to(5)
      end
    end

    it "should increase the number of hearings" do
      VCR.use_cassette('20140709_F501') do
        expect{factory.run}.to change{Hearing.count}.from(0).to(5)
      end
    end

    it "should increase the number of parties" do
      VCR.use_cassette('20140709_F501') do
        expect{factory.run}.to change{Party.count}.from(0).to(17)
      end
    end

  end

  context "with multiple courtrooms" do
    factory = CbmCalendarFactory.new(date: "20140630", time: "8.15",
                                    departments: ["F201", "F301", "F401", "F402"])

    it "should increase the number of calendars" do
      VCR.use_cassette('20140630_Triage') do
        expect{factory.run}.to change{Calendar.count}.from(0).to(1)
      end
    end

    it "should increase the number of cases" do
      VCR.use_cassette('20140630_Triage') do
        expect{factory.run}.to change{CaseNumber.count}.from(0).to(110)
      end
    end

    it "should increase the number of matters" do
      VCR.use_cassette('20140630_Triage') do
        expect{factory.run}.to change{CaseNumber.count}.from(0).to(110)
      end
    end

    it "should increase the number of hearings" do
      VCR.use_cassette('20140630_Triage') do
        expect{factory.run}.to change{Hearing.count}.from(0).to(26)
      end
    end

    it "should increase the number of parties" do
      VCR.use_cassette('20140630_Triage') do
        expect{factory.run}.to change{Party.count}.from(0).to(86)
      end
    end

  end
end
