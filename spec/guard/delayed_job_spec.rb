require 'spec_helper'

describe Guard::DelayedJob do
  subject { Guard::DelayedJob.new }

  describe "start" do
    before do
      subject = Guard::DelayedJob.new
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
