require 'spec_helper'

describe Party do
  it { should respond_to :case_number }
  it { should respond_to :number }
  it { should respond_to :category }
  it { should respond_to :first }
  it { should respond_to :middle }
  it { should respond_to :last }
  it { should respond_to :suffix }
end
