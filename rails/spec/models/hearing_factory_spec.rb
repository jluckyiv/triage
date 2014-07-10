require 'spec_helper'

describe HearingFactory do
  it { should respond_to :run }

  context "with valid data" do
    describe "#run" do
      it "should return a hearing" do
        factory = HearingFactory.new('matter_id' => 1, 'time' => "8.00", 'description' => "description")
        expect(factory.run).to be_instance_of(Hearing)
      end

      it "should return a hearing with the correct attributes" do
        factory = HearingFactory.new('matter_id' => 1, 'time' => "8.00", 'description' => "description")
        expect(factory.run.md5).to eq("67daf92c833c41c95db874e18fcb2786")
      end

      it "should create a hearing" do
        factory = HearingFactory.new('matter_id' => 1, 'time' => "8.00", 'description' => "description")
        expect{factory.run}.to change{Hearing.count}.from(0).to(1)
      end

      it "should create a hearing with the correct attributes" do
        factory = HearingFactory.new('matter_id' => 1, 'time' => "8.00", 'description' => "description")
        factory.run
        expect(Hearing.last.md5).to eq("67daf92c833c41c95db874e18fcb2786")
      end

      it "should not create a duplicate hearing" do
        factory1 = HearingFactory.new('matter_id' => 1, 'time' => "8.00", 'description' => "description")
        factory2 = HearingFactory.new('matter_id' => 1, 'time' => "8.00", 'description' => "description")
        factory1.run
        expect{factory2.run}.not_to change{Hearing.count}
      end

      it "should create a duplicate hearing with a different matter id" do
        factory1 = HearingFactory.new('matter_id' => 1, 'time' => "8.00", 'description' => "description")
        factory2 = HearingFactory.new('matter_id' => 2, 'time' => "8.00", 'description' => "description")
        factory1.run
        expect{factory2.run}.to change{Hearing.count}.by 1
      end

    end
  end
end
