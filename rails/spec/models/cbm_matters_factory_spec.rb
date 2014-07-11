require 'spec_helper'

describe CbmMattersFactory do

  subject { CbmMattersFactory.new(department: "F401", date: "20140630") }

  it { should respond_to :run }

  context "with single courtroom" do

    it "should create case numbers" do
      VCR.use_cassette('20140630_F401') do
        expect{subject.run}.to change{CaseNumber.count}.from(0).to(23)
      end
    end

    it "should create matters" do
      VCR.use_cassette('20140630_F401') do
        expect{subject.run}.to change{Matter.count}.from(0).to(23)
      end
    end

    it "should create hearings" do
      VCR.use_cassette('20140630_F401') do
        expect{subject.run}.to change{Hearing.count}.from(0).to(26)
      end
    end

    it "should return matters" do
      VCR.use_cassette('20140630_F401') do
        expect(subject.run).to have(23).items
      end
    end

    it "should not recreate case numbers" do
      VCR.use_cassette('20140630_F401') do
        subject.run
        expect{subject.run}.not_to change{CaseNumber.count}.from(23).to(46)
      end
    end

    it "should not recreate matters" do
      VCR.use_cassette('20140630_F401') do
        subject.run
        expect{subject.run}.not_to change{Matter.count}.from(23).to(46)
      end
    end

  end

  context "with a specific time" do

    subject { CbmMattersFactory.new(department: "F401", date: "20140630", time: "8.15") }
    it "should return matters" do
      VCR.use_cassette('20140630_F401') do
        expect(subject.run).to have(3).items
      end
    end

  end

end
