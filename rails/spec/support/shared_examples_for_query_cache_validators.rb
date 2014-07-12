shared_examples "cache_validator" do

  it { should respond_to :run }
  it { should respond_to :query }
  it { should respond_to :cache }

end
