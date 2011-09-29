require 'spec_helper'

describe Guard::Resque do
  subject { Guard::Resque.new }

  describe "start" do
    before do
      subject = Guard::Resque.new
    end

    after do
      subject.stop
    end

    it "should create a pid in /tmp/pids" do
      subject.start
      Dir.glob("tmp/pids/resque*.pid").should_not be_empty
    end
  end
end
