require 'spec_helper'

describe Courthouse do
  it { should respond_to :branch_name }
  it { should respond_to :county }
  it { should respond_to :address }
  it { should respond_to :departments }
end
