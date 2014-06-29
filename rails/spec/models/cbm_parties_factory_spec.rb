require 'spec_helper'

describe CbmPartiesFactory do

  subject { CbmPartiesFactory.new(case_number: "1203066") }
  it { should respond_to :read }

end
