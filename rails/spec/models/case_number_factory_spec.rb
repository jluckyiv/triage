describe CaseNumberFactory do

  subject { CaseNumberFactory.new(case_number: "1203066") }
  it { should respond_to :run }
end
