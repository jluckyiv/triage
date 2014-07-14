require 'spec_helper'

describe Attorney do
  it { should respond_to :name }
  it { should respond_to :name_digest }
  it { should respond_to :address }
  it { should respond_to :email }
  it { should respond_to :phone }
  it { should respond_to :sbn }

  describe "#clients" do
    attorney = Attorney.create(name: "attorney")
    party = attorney.clients.new
    it "should create a party" do
      expect(party.attorney_id).to eq attorney.id
    end
  end

  describe "#name_digest" do
    a = Attorney.create(name: "a")
    it "should produce the correct SHA1 when instantiated" do
      expect(a.name_digest).to eq "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8"
    end
  end
end
