require 'spec_helper'

describe CbmPartiesQueryCache do
  it { should respond_to :court_code }
  it { should respond_to :case_type }
  it { should respond_to :case_number }
  it { should respond_to :md5 }
  it { should respond_to :content_length }
end
