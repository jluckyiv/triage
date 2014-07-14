require 'spec_helper'

describe Address do
  it { should respond_to :addressable }
  it { should respond_to :street1 }
  it { should respond_to :street2 }
  it { should respond_to :city }
  it { should respond_to :state }
  it { should respond_to :zip }
end
