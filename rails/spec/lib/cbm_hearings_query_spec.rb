require 'spec_helper'

describe CbmHearingsQuery do
  it { should respond_to :where }

  describe "#where" do
    it "should have six departments" do
      VCR.use_cassette("cbm_hearings_query_20140729") do
        query = CbmHearingsQuery.new.where(date: "20140729")
        expect(query).to have(6).items
      end
    end

    it "should have six departments" do
      VCR.use_cassette("cbm_hearings_query_20140729") do
        query = CbmHearingsQuery.new.where(date: "20140729")
        expect(query).to have(6).items
      end
    end

    describe "hearings for departments" do

      context "with no cases" do
        it "should return 'NOTHING'" do
          results = {"F401"=>0}
          VCR.use_cassette("cbm_hearings_query_20140728") do
            query = CbmHearingsQuery.new.where(date: "20140728")
            results.each do |k,v|
              dept  = query.find {|c| c['department'] == k}
              expect(dept['case']).to eq "NOTHING"
            end
          end
        end
      end

      context "with cases for every department" do
        it "should have the correct number of cases for each department" do
          results = {"F201"=>29,"F301"=>23,"F401"=>2,"F402"=>27,"F501"=>22,"F502"=>8}
          VCR.use_cassette("cbm_hearings_query_20140729") do
            query = CbmHearingsQuery.new.where(date: "20140729")
            results.each do |k,v|
              dept  = query.find {|c| c['department'] == k}
              expect(dept['case']).to have(v).items
            end
          end
        end
      end
    end

  end
end
