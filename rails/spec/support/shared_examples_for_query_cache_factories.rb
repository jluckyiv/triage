shared_examples "cache_factory" do

  it { should respond_to :run }
  it { should respond_to :needs_update? }
  it { should respond_to :query }
  it { should respond_to :cache }

end
