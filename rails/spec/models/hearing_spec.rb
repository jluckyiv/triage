require 'spec_helper'

describe Hearing do
  it { should respond_to :department }
  it { should respond_to :proceeding }
  it { should respond_to :date_time }
  it { should respond_to :interpreter }
end
