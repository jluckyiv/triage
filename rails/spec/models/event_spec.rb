require 'spec_helper'

describe Event do
  it { should respond_to :matter }
  it { should respond_to :category }
  it { should respond_to :subject }
  it { should respond_to :action }

  it "should save a matter" do
    e = Event.new(matter_id: 1, category: "category", subject: "subject", action: "action")
    expect(e.save).to be_true
  end
end

