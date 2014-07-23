require 'spec_helper'

describe Proceeding do
  it { should respond_to :description }
  it { should respond_to :description_digest }

  describe "#description_digest" do
    a = Proceeding.create(description: "a")
    it "should produce the correct SHA1 when instantiated" do
      expect(a.description_digest).to eq "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8"
    end
  end
end
