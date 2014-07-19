require_relative '../../app/models/query_manager'

describe QueryManager do
  it { should respond_to :run }
  it { should respond_to :run_all }
  it { should respond_to :run_once }
  it { should respond_to :run_one }

  context "with a single request" do
    qm = QueryManager.new
    it "should return a result" do
      pending
    end
  end
end
