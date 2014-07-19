require 'spec_helper'

describe Matters do
  it { should respond_to :parties }
  it { should respond_to :hearings }
  it { should respond_to :events }
  it { should respond_to :court_code }
  it { should respond_to :case_type }
  it { should respond_to :case_number }
  it { should respond_to :full_case_number }

    describe "#full_case_number" do
    matter = Matter.new(court_code: "F", case_type: "RID", case_number: "1234567")
    it "should concatenate the case_type and case_number" do
      expect(matter.full_case_number).to eq "RID1234567"
    end
  end
end
