require_relative '../../app/models/query_manager'

describe QueryManager.instance do
  it { should respond_to :run }
  it { should respond_to :run_all }
  it { should respond_to :run_once }
  it { should respond_to :run_one }

  context "with a single request" do
    # before { pending "Only works individually. Fails if run with all tests." }
    it "should return a result" do
      VCR.use_cassette "github_jluckyiv" do
        uris = %w[https://api.github.com/users/jluckyiv http://google.com http://yahoo.com]
        result = QueryManager.instance.run_once(uris)
        expect(result.return_code).to eq :ok
      end
    end
  end

  context "with multiple requests" do
    it "should return multiple results" do
      VCR.use_cassette "google_yahoo" do
        uris = %w[http://google.com http://yahoo.com]
        expect(QueryManager.instance.run(uris)).to have(2).items
      end
    end
  end
end
