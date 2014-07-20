require_relative '../../app/models/query_manager'

describe QueryManager.instance do
  it { should respond_to :run }
  it { should respond_to :run_all }
  it { should respond_to :run_once }
  it { should respond_to :run_one }

  context "with a single request" do
    before { pending "Only works individually. Fails if run with all tests." }
    it "should return a result" do
      VCR.use_cassette "github_jluckyiv" do
        uris = %w[https://api.github.com/users/jluckyiv http://google.com http://yahoo.com]
        result = QueryManager.instance.run_once(uris)
        expect(result.return_code).to eq :ok
      end
    end
  end

  context "with unreachable request" do
    before { pending "Doesn't seem to use VCR" }
    it "should return an appropriate response" do
      VCR.use_cassette "unreachable" do
        uris = ["https://riv-dev1/cbm/hearings.aspx?cc=F&dept=F501&date=20140422"]
        result = QueryManager.instance.run(uris).first
        expect(result.response_body).to eq ""
        expect(result.response_headers).to eq ""
        expect(result.response_code).to eq 0
        expect(result.return_code.to_s).to match /couldnt/
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
