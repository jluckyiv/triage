describe QueryManagerResult do
  it { should respond_to :response_body }
  it { should respond_to :response_code }
  it { should respond_to :response_headers }
  it { should respond_to :return_code }
end
