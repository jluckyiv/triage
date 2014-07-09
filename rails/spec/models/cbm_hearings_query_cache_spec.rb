require 'spec_helper'

describe CbmHearingsQueryCache do
  it { should respond_to :court_code }
  it { should respond_to :department }
  it { should respond_to :date }
  it { should respond_to :md5 }
  it { should respond_to :content_length }

end
