describe CbmHearingsQueryImporter do
  it { should respond_to :import }

  it "should import the right number of matters" do
    VCR.use_cassette("cbm_hearings_query_20140724") do
      expect{CbmHearingsQueryImporter.import(date: "20140724")}.to change{Matter.count}.by(20)
    end
  end

  it "should import the right number of parties" do
    VCR.use_cassette("cbm_hearings_query_20140724") do
      expect{CbmHearingsQueryImporter.import(date: "20140724")}.to change{Party.count}.by(20)
    end
  end

  it "should import the right number of matters" do
    VCR.use_cassette("cbm_hearings_query_20140724") do
      expect{CbmHearingsQueryImporter.import(date: "20140724")}.to change{Matter.count}.by(20)
    end
  end

  it "should import the right number of hearings" do
    VCR.use_cassette("cbm_hearings_query_20140724") do
      expect{CbmHearingsQueryImporter.import(date: "20140724")}.to change{Hearing.count}.by(28)
    end
  end
end
