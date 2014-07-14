require 'spec_helper'

describe Party do
  it { should respond_to :case_number }
  it { should respond_to :number }
  it { should respond_to :role }
  it { should respond_to :name }
  it { should respond_to :dob }
  it { should respond_to :attorney }
  it { should respond_to :email }
  it { should respond_to :phone }
end
