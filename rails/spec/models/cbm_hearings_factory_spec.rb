require 'spec_helper'

describe CbmHearingsFactory do

  subject { CbmHearingsFactory.new(department: "F501") }
  it { should respond_to :run }

end
