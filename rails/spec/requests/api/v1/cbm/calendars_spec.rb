require 'spec_helper'

describe "Calendars API" do
  it "should return a list of departments and cases" do
    VCR.use_cassette('api-v1-cbm-calendars-F501-20140630') do
      get 'api/v1/cbm/calendars?cc=F&dept=F501&date=20140630'
      expect(response).to be_success
    end
  end
end

