require 'spec_helper'

describe Matter do
  it { should respond_to :date }
  it { should respond_to :department }
  it { should respond_to :case_number }
  it { should respond_to :petitioner }
  it { should respond_to :respondent }
  it { should respond_to :events }
  it { should_not respond_to :calendar }
end
