require 'spec_helper'

describe TriageMatter do

  its(:class) { should respond_to :where }
  its(:class) { should respond_to :find }

  describe ".find" do
      it "should have matters for four departments" do
        VCR.use_cassette("triage_matter_20140728") do
          result = TriageMatter.find("20140728")
          expect(result).to have(4).items
      end
    end
  end

  describe ".where" do
    context "with date" do
      it "should have matters for four departments" do
        VCR.use_cassette("triage_matter_20140728") do
          result = TriageMatter.where(date: "20140728")
          expect(result).to have(4).items
        end
      end
    end
  end

end
