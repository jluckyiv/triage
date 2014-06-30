require 'spec_helper'

describe CbmCaseNumberFactory do
  subject { CbmCaseNumberFactory.new(case_number: "1203066") }
  it { should respond_to :court_code }
  it { should respond_to :case_type }
  it { should respond_to :case_number }

  its(:court_code) { should eq "F" }
  its(:case_type) { should eq "RID" }
  its(:case_number) { should eq "1203066" }
  it "should produce the correct hash" do
    expect(subject.to_h).to eq({
      court_code: "F",
      case_type: "RID",
      case_number: "1203066"
    })
  end
  it "should produce a new CaseNumber" do
    case_number = subject.run
    expect(case_number).to be_instance_of(CaseNumber)
    expect(case_number).to be_valid
  end
end

