require 'spec_helper'

describe CalendarFactory do

  it { should respond_to :run }

  describe "#run" do
    context "with default values" do
      it "should send the proper message to the adapter" do
        adapter = double("adapter")
        departments = %w[F201 F301 F401 F402]
        date = Date.today.strftime("%Y%m%d")
        time = "8.15"
        adapter.should_receive(:run).with("F201", date: date, time: time)
        adapter.should_receive(:run).with("F301", date: date, time: time)
        adapter.should_receive(:run).with("F401", date: date, time: time)
        adapter.should_receive(:run).with("F402", date: date, time: time)
        factory = CalendarFactory.new(adapter: adapter)
        factory.run
      end
    end

    context "with specified courtroom and date" do
      it "should send the proper message to the adapter" do
        adapter = double("adapter")
        adapter.should_receive(:run).with("F201", date: "20140623", time: "8.30")
        factory = CalendarFactory.new(adapter: adapter)
        factory.run(departments: "F201", date: "20140623", time: "8.30")
      end
    end

    context "with specified courtrooms and date" do
      it "should send the proper message to the adapter" do
        adapter = double("adapter")
        adapter.should_receive(:run).with("F201", date: "20140623", time: "8.30")
        adapter.should_receive(:run).with("F301", date: "20140623", time: "8.30")
        factory = CalendarFactory.new(adapter: adapter)
        factory.run(departments: %w[F201 F301], date: "20140623", time: "8.30")
      end
    end

  end

  it "should return a list of matters for one department" do
    adapter = double("adapter")
    matter1 = mock_model('Matter')
    matter2 = mock_model('Matter')
    matter3 = mock_model('Matter')
    adapter.stub(:run).and_return( [matter1, matter2, matter3])

    factory = CalendarFactory.new(adapter: adapter)
    expect(factory.run(departments: "F301", date: "20140623")).to eq [matter1, matter2, matter3]
  end

  it "should return a concatendated list of matters for multiple departments" do
    adapter = double("adapter")
    matter1 = mock_model('Matter')
    matter2 = mock_model('Matter')
    matter3 = mock_model('Matter')
    matter4 = mock_model('Matter')
    adapter.stub(:run).and_return( [matter1, matter2], [matter3], [matter4])

    factory = CalendarFactory.new(adapter: adapter)
    expect(factory.run(departments: %w[F201 F301 F501], date: "20140623")).to eq [matter1, matter2, matter3, matter4]
  end


end
