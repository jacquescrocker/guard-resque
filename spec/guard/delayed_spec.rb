require 'spec_helper'

describe Guard::Delayed do
  subject { Guard::Delayed.new }

  describe "start" do
    before do
      subject = Guard::Delayed.new
    end

    after do
      subject.stop
    end

    it "should create a pid in /tmp/pids" do
      subject.start
      Dir.glob("tmp/pids/delayed_job*.pid").should_not be_empty
    end
  end
end
