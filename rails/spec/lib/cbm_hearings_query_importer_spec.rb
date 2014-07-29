describe CbmHearingsQueryImporter do
  it { should respond_to :import }

  it "should import the right number of matters" do
    VCR.use_cassette("cbm_hearings_query_importer_20140728_F401_F201") do
      query = CbmHearingsQuery.where(date: "20140728", dept: %w[F401 F201])
      CbmHearingsQueryImporter.import(query)
      expect(Matter.count).to eq(34)
    end
  end

  it "should not duplicate matters" do
    VCR.use_cassette("cbm_hearings_query_importer_20140728_F201") do
      query = CbmHearingsQuery.where(date: "20140728", dept: %w[F201])
      CbmHearingsQueryImporter.import(query)
      CbmHearingsQueryImporter.import(query)
      expect(Matter.count).to eq(34)
    end
  end

  it "should import the right number of parties" do
    VCR.use_cassette("cbm_hearings_query_importer_20140728_F401_F201") do
      query = CbmHearingsQuery.where(date: "20140728", dept: %w[F401 F201])
      CbmHearingsQueryImporter.import(query)
      expect(Party.count).to eq(183)
    end
  end

  it "should import the right number of proceedings" do
    VCR.use_cassette("cbm_hearings_query_importer_20140728_F401_F201") do
      query = CbmHearingsQuery.where(date: "20140728", dept: %w[F401 F201])
      CbmHearingsQueryImporter.import(query)
      expect(Proceeding.count).to eq(37)
    end
  end

  it "should import the right number of hearings" do
    VCR.use_cassette("cbm_hearings_query_importer_20140728_F401_F201") do
      query = CbmHearingsQuery.where(date: "20140728", dept: %w[F401 F201])
      expect{CbmHearingsQueryImporter.import(query)}.to change{Hearing.count}.by(38)
    end
  end
end
