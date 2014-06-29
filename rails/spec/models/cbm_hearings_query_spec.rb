require 'spec_helper'

describe CbmHearingsQuery do
  it { should respond_to :court_code }
  it { should respond_to :department }
  it { should respond_to :date }
  it { should respond_to :response }
  it { should respond_to :md5 }
end
