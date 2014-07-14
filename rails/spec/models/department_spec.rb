require 'spec_helper'

describe Department do
  it { should respond_to :courthouse }
  it { should respond_to :hearings }
  it { should respond_to :name }
  it { should respond_to :judicial_officer }
end
