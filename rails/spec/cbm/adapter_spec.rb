require_relative '../../app/cbm/adapter'

describe Cbm::Adapter do
  it { should respond_to :parties }
  it { should respond_to :hearings }
end

