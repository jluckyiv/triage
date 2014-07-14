require_relative '../../app/cbm/query_manager'

describe Cbm::QueryManager do
  it { should respond_to :run }
  it { should respond_to :run_all }
  it { should respond_to :run_once }
  it { should respond_to :run_one }

  context "with a single request" do
    qm = Cbm::QueryManager.new
    it "should return a result" do
      pending
    end
  end
end
