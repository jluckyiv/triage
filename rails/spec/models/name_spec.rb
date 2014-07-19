require 'spec_helper'

describe Name do
  it { should respond_to :first }
  it { should respond_to :middle }
  it { should respond_to :last }
  it { should respond_to :suffix }
end
