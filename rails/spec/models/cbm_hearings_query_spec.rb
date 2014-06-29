require 'spec_helper'

describe CbmHearingsQuery do
  subject { CbmHearingsQuery.new(department: 'F501') }
  it { should respond_to :court_code }
  it { should respond_to :department }
  it { should respond_to :date }
  it { should respond_to :header }
  it { should respond_to :body }
  it { should respond_to :content_length }
  it { should respond_to :md5 }

  it "should default to court_code 'F'" do
    expect(subject.court_code).to eq 'F'
  end

  it "should default to today's date" do
    expect(subject.date).to eq Date.today.strftime('%Y%m%d')
  end
end
