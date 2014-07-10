require 'spec_helper'

describe CbmCalendarFactory do

  it { should respond_to :run }

  context "with a single courtroom" do
    factory = CbmCalendarFactory.new(date: "20140709", time: "8.30", departments: ["F501"])

    it "should return the matters" do
      VCR.use_cassette('20140709_F501') do
        expect(factory.run).to have(5).items
      end
    end

    it "should increase the number of matters" do
      VCR.use_cassette('20140709_F501') do
        expect{factory.run}.to change{Matter.count}.from(0).to(5)
      end
    end

    it "should increase the number of cases" do
      VCR.use_cassette('20140709_F501') do
        expect{factory.run}.to change{CaseNumber.count}.from(0).to(5)
      end
    end

    it "should increase the number of hearings" do
      VCR.use_cassette('20140709_F501') do
        expect{factory.run}.to change{Hearing.count}.from(0).to(5)
      end
    end

    it "should increase the number of parties" do
      VCR.use_cassette('20140709_F501', allow_playback_repeats: true) do
        expect{factory.run}.to change{Party.count}.from(0).to(18)
      end
    end

  end

  context "with multiple courtrooms" do
    factory = CbmCalendarFactory.new(date: "20140630",
                                     departments: ["F201", "F301", "F401", "F402"])

    it "should increase the number of cases" do
      VCR.use_cassette('20140630_Triage', allow_playback_repeats: true) do
        expect{factory.run}.to change{CaseNumber.count}.from(0).to(111)
      end
    end

    it "should increase the number of matters" do
      VCR.use_cassette('20140630_Triage', allow_playback_repeats: true) do
        expect{factory.run}.to change{Matter.count}.from(0).to(112)
      end
    end

    it "should increase the number of hearings" do
      VCR.use_cassette('20140630_Triage', allow_playback_repeats: true) do
        expect{factory.run}.to change{Hearing.count}.from(0).to(123)
      end
    end

    it "should increase the number of parties" do
      VCR.use_cassette('20140630_Triage', allow_playback_repeats: true) do
        expect{factory.run}.to change{Party.count}.from(0).to(518)
      end
    end

  end

  context "with multiple courtrooms for triage" do
    factory = CbmCalendarFactory.new(date: "20140630", time: "8.15",
                                     departments: ["F201", "F301", "F401", "F402"])

    it "should increase the number of cases" do
      VCR.use_cassette('20140630_Triage') do
        expect{factory.run}.to change{CaseNumber.count}.from(0).to(24)
      end
    end

    it "should increase the number of matters" do
      VCR.use_cassette('20140630_Triage') do
        expect{factory.run}.to change{CaseNumber.count}.from(0).to(24)
      end
    end

    it "should increase the number of hearings" do
      VCR.use_cassette('20140630_Triage') do
        expect{factory.run}.to change{Hearing.count}.from(0).to(26)
      end
    end

    it "should increase the number of parties" do
      VCR.use_cassette('20140630_Triage') do
        expect{factory.run}.to change{Party.count}.from(0).to(91)
      end
    end

  end

  context "with single courtroom for triage" do
    factory = CbmCalendarFactory.new(date: "20140630", time: "8.15",
                                     departments: ["F201"])

    it "should increase the number of cases" do
      VCR.use_cassette('20140630_8.15_F201') do
        expect{factory.run}.to change{CaseNumber.count}.from(0).to(7)
      end
    end

    it "should increase the number of matters" do
      VCR.use_cassette('20140630_8.15_F201') do
        expect{factory.run}.to change{CaseNumber.count}.from(0).to(7)
      end
    end

    it "should increase the number of hearings" do
      VCR.use_cassette('20140630_8.15_F201') do
        expect{factory.run}.to change{Hearing.count}.from(0).to(7)
      end
    end

    it "should increase the number of parties" do
      VCR.use_cassette('20140630_8.15_F201') do
        expect{factory.run}.to change{Party.count}.from(0).to(26)
      end
    end

  end

  context "with single courtroom for triage" do
    factory = CbmCalendarFactory.new(date: "20140630", time: "8.15",
                                     departments: ["F301"])

    it "should increase the number of cases" do
      VCR.use_cassette('20140630_8.15_F301') do
        expect{factory.run}.to change{CaseNumber.count}.from(0).to(9)
      end
    end

    it "should increase the number of matters" do
      VCR.use_cassette('20140630_8.15_F301') do
        expect{factory.run}.to change{CaseNumber.count}.from(0).to(9)
      end
    end

    it "should increase the number of hearings" do
      VCR.use_cassette('20140630_8.15_F301') do
        expect{factory.run}.to change{Hearing.count}.from(0).to(11)
      end
    end

    it "should increase the number of parties" do
      VCR.use_cassette('20140630_8.15_F301') do
        expect{factory.run}.to change{Party.count}.from(0).to(34)
      end
    end

  end

end
