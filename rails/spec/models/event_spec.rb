require 'spec_helper'

describe Event do
  it { should respond_to :matter }
  it { should respond_to :category }
  it { should respond_to :subject }
  it { should respond_to :action }
end

