require 'spec_helper'

describe "Triage API" do
  it "should return a list of departments and cases" do
    VCR.use_cassette('api-v1-cbm-triage-matters-20140714') do
      get 'api/v1/cbm/triage/matters/20140714'
      expect(response).to be_success
    end
  end
end
