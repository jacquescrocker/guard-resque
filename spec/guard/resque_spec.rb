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

    it "should accept environment option" do
      obj = Guard::Resque.new [], :environment => 'foo'
      obj.send(:cmd).should match /RAILS_ENV=foo/
    end

    it "should accept queue option" do
      obj = Guard::Resque.new [], :queue => 'foo'
      obj.send(:cmd).should match /QUEUE=foo/
    end

    it "should accept count option" do
      obj = Guard::Resque.new [], :count => 2
      obj.send(:cmd).should match /COUNT=2/
    end

    it "should accept verbose option" do
      obj = Guard::Resque.new [], :verbose => true
      obj.send(:cmd).should match /VVERBOSE=1/
    end

    it "should accept trace option" do
      obj = Guard::Resque.new [], :trace => true
      obj.send(:cmd).should match /--trace/
    end

    it "should accept task option" do
      obj = Guard::Resque.new [], :task => 'environment foo'
      obj.send(:cmd).should match /environment foo/
      obj.send(:cmd).should_not match /resque:work/
    end
  end
end
