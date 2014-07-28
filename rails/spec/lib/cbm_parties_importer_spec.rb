require 'spec_helper'

describe CbmPartiesImporter do
  it { should respond_to :import }

  context "update cached values" do
    pending "Must implement updates"
  end

  context "with a single case number" do
    it "should create a matter" do
      VCR.use_cassette("cbm_parties_query_RID1203066") do
        importer = CbmPartiesImporter.new
        expect{importer.import("RID1203066")}.to change{Matter.count}.by(1)
      end
    end

    it "should not duplicate a  matter" do
      VCR.use_cassette("cbm_parties_query_RID1203066") do
        importer = CbmPartiesImporter.new
        importer.import("RID1203066")
        expect{importer.import("RID1203066")}.to change{Matter.count}.by(0)
      end
    end

  end

  it "should create a matter with a case number hash" do
    VCR.use_cassette("cbm_parties_query_RID1203066") do
      importer = CbmPartiesImporter.new
      importer.import("RID1203066")
      expect{importer.import({
        court_code: "F",
        case_type:  "RID",
        case_number: "1203066"
      })}.to change{Matter.count}.by(0)
    end
  end

  context "with multiple case numbers" do
    it "should create two matters" do
      VCR.use_cassette("cbm_parties_query_RID1203066_RID1203067") do
        importer = CbmPartiesImporter.new
        expect{importer.import(["RID1203066", "RID1203067"])}.to change{Matter.count}.by(2)
      end
    end

    it "should not duplicate a matter" do
      VCR.use_cassette("cbm_parties_query_RID1203068_RID1203069") do
        importer = CbmPartiesImporter.new
        importer.import(["RID1203068", "RID1203069"])
        expect{importer.import(["RID1203068", "RID1203069"])}.to change{Matter.count}.by(0)
      end
    end

    it "should create two matters with case number hashes" do
      VCR.use_cassette("cbm_parties_query_RID1203066_RID1203067") do
        importer = CbmPartiesImporter.new
        expect{importer.import([{
          court_code: "F",
          case_type:  "RID",
          case_number: "1203066"
        }, {
          court_code: "F",
          case_type:  "RID",
          case_number: "1203067"
        }])}.to change{Matter.count}.by(2)
      end
    end
  end

  it "should create two matters, one with hash input, one with string" do
    VCR.use_cassette("cbm_parties_query_RID1203066_RID1203067") do
      importer = CbmPartiesImporter.new
      expect{importer.import([{
        court_code: "F",
        case_type:  "RID",
        case_number: "1203066"
      }, "RID1203067" ])}.to change{Matter.count}.by(2)
    end
  end

  describe "parties" do
    it "should create parties" do
      VCR.use_cassette("cbm_parties_query_RID1203066") do
        importer = CbmPartiesImporter.new
        expect{importer.import("RID1203066")}.to change{Party.count}.by(3)
      end
    end

    it "should not duplicate parties" do
      VCR.use_cassette("cbm_parties_query_RID1203066") do
        importer = CbmPartiesImporter.new
        importer.import("RID1203066")
        expect{importer.import("RID1203066")}.to change{Party.count}.by(0)
      end
    end

  end
end
