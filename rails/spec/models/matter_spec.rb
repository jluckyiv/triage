require 'spec_helper'

describe Matter do
  it { should respond_to :calendar }
  it { should respond_to :events }
  it { should respond_to :case_number }
end
