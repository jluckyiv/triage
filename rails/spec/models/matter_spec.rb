require 'spec_helper'

describe Matter do
  it { should respond_to :parties }
  it { should respond_to :hearings }
  it { should respond_to :events }
  it { should respond_to :court_code }
  it { should respond_to :case_type }
  it { should respond_to :case_number }

  context "with invalid data" do
    it "should not create a record" do
      expect{Matter.create(court_code: "", case_type: "", case_number: "")}.to_not change{Matter.count}.by(1)
      :A
    end
  end
  context "duplicate case numbers" do
    it "should not allow a duplicate case number" do
      Matter.create(court_code: "F", case_type: "RID", case_number: "1234567")
      expect{Matter.find_or_create_by(
        court_code: "F", case_type: "RID", case_number: "1234567"
      )}.to_not change{Matter.count}.by(1)
      expect(Matter.find_by_full_case_number "RID1234567").to_not be_nil
    end
  end

  describe ".create_with_full_case_number" do
    it "should create a matter" do
      Matter.create_with_full_case_number("RID1234567")
      expect(Matter.find_by_full_case_number "RID1234567").to_not be_nil
    end
  end

  describe ".find_by_full_case_number" do
    it "should not be nil" do
      Matter.create(court_code: "F", case_type: "RID", case_number: "1234567")
      expect(Matter.find_by_full_case_number "RID1234567").to_not be_nil
    end
  end

  describe ".find_or_create_by_full_case_number" do
    it "should not be nil" do
      Matter.find_or_create_by_full_case_number("RID1234567")
      expect{Matter.find_or_create_by_full_case_number("RID1234567")}.to_not change{Matter.count}.by(1)
    end
  end

  context "associations" do
    it "should not allow a proceeding without a matter" do
      pending
      p = Proceeding.new(description: "proceeding")
      expect(p.save).to be_false
    end

    it "should not allow a party without a matter" do
      p = Party.new
      expect(p.save).to be_false
    end
  end
end
