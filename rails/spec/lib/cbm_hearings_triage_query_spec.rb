require 'spec_helper'

describe CbmHearingsTriageQuery do

  its(:class) { should respond_to :where }
  its(:class) { should respond_to :find }

  describe ".find" do
    it "should have matters for four departments" do
      VCR.use_cassette("cbm_hearings_triage_query_20140728") do
        results = CbmHearingsTriageQuery.find("20140728")
        expect(results).to have(4).items
      end
    end

    it "should have the correct number of cases" do
      VCR.use_cassette("cbm_hearings_triage_query_20140728") do
        results = CbmHearingsTriageQuery.find("20140728")
        hearings = Array.wrap(results).each_with_object([]) {|result, list|
          list.concat(result['case'])
        }
        # TODO: should be 16 items, but CBM is not deleting vacated hearings from query
        # RID1402406
        expect(hearings).to have(17).items
      end
    end

    it "should have the correct number of cases" do
      VCR.use_cassette("cbm_hearings_triage_query_20140729") do
        results = CbmHearingsTriageQuery.find("20140729")
        hearings = Array.wrap(results).each_with_object([]) {|result, list|
          list.concat(result['case'])
        }
        # TODO: should be 18 items, but CBM is not deleting vacated hearings from query
        # RID1402416, RID14025432
        expect(hearings).to have(20).items
      end
    end
  end

  describe ".where" do
    context "with date" do
      it "should have matters for four departments" do
        VCR.use_cassette("cbm_hearings_triage_query_20140728") do
          results = CbmHearingsTriageQuery.where(date: "20140728")
          expect(results).to have(4).items
        end
      end
    end
  end

end
