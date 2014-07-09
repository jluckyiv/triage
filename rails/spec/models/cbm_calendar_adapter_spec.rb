require 'spec_helper'

describe CbmCalendarAdapter do
  before { pending }

  it { should respond_to :run }

  context "with a single courtroom" do
    adapter = CbmCalendarAdapter.new

    # it "should increase the number of cases" do
    #   VCR.use_cassette('20140709_F501') do
    #     expect{adapter.run(date: "20140709", time: "8.30", departments: ["F501"])}.to change{CaseNumber.count}.from(0).to(5)
    #   end
    # end

    it "should increase the number of matters" do
      VCR.use_cassette('20140709_F501') do
        expect{adapter.run("F501", date: "20140709", time: "8.30")}.to change{Matter.count}.from(0).to(5)
      end
    end

    # it "should increase the number of hearings" do
    #   VCR.use_cassette('20140709_F501') do
    #     expect{adapter.run(date: "20140709", time: "8.30", departments: ["F501"])}.to change{Hearing.count}.from(0).to(5)
    #   end
    # end

    # it "should increase the number of parties" do
    #   VCR.use_cassette('20140709_F501') do
    #     expect{adapter.run(date: "20140709", time: "8.30", departments: ["F501"])}.to change{Party.count}.from(0).to(17)
    #   end
    # end

  end

  context "with multiple courtrooms" do
    adapter = CbmCalendarAdapter.new

    # it "should increase the number of cases" do
    #   VCR.use_cassette('20140630_Triage') do
    #     expect{adapter.run(date: "20140630", time: "8.15", departments: ["F201", "F301", "F401", "F402"])}.to change{CaseNumber.count}.from(0).to(110)
    #   end
    # end

    # it "should increase the number of matters" do
    #   VCR.use_cassette('20140630_Triage') do
    #     expect{adapter.run}.to change{CaseNumber.count}.from(0).to(110)
    #   end
    # end

    # it "should increase the number of hearings" do
    #   VCR.use_cassette('20140630_Triage') do
    #     expect{adapter.run}.to change{Hearing.count}.from(0).to(26)
    #   end
    # end

    # it "should increase the number of parties" do
    #   VCR.use_cassette('20140630_Triage') do
    #     expect{adapter.run}.to change{Party.count}.from(0).to(86)
    #   end
    # end

  end

end
