require 'spec_helper'

describe Guard::Resque do
  describe 'start' do

    it 'should accept :environment option' do
      environment = :foo

      obj = Guard::Resque.new [], :environment => environment
      obj.send(:env).should include 'RAILS_ENV' => environment.to_s
    end

    it 'should accept :queue option' do
      queue = :foo

      obj = Guard::Resque.new [], :queue => queue
      obj.send(:env).should include 'QUEUE' => queue.to_s
    end

    it 'should accept :count option' do
      count = 2

      obj = Guard::Resque.new [], :count => count
      obj.send(:env).should include 'COUNT' => count.to_s
    end

    it 'should accept :vverbose option' do
      obj = Guard::Resque.new [], :vverbose => true
      obj.send(:env).should include 'VVERBOSE'
    end

    it 'should accept :verbose option' do
      obj = Guard::Resque.new [], :verbose => true
      obj.send(:env).should include 'VERBOSE'
    end

    it 'should accept :trace option' do
      obj = Guard::Resque.new [], :trace => true
      obj.send(:cmd).should include '--trace'
    end

    it 'should accept :task option' do
      task = 'environment foo'

      obj = Guard::Resque.new [], :task => task
      obj.send(:cmd).should include task
      obj.send(:cmd).should_not include Guard::Resque::DEFAULT_TASK_SINGLE
    end

    it 'should provide default options' do
      obj = Guard::Resque.new []
      obj.send(:env).should include 'QUEUE' => Guard::Resque::DEFAULT_QUEUE.to_s
      obj.send(:env).should include 'COUNT' => Guard::Resque::DEFAULT_COUNT.to_s
      obj.send(:cmd).should include Guard::Resque::DEFAULT_TASK_SINGLE
    end

    it 'should provide different default options when :count is multiple' do
      count = 2

      obj = Guard::Resque.new [], :count => count
      obj.send(:env).should include 'QUEUE' => Guard::Resque::DEFAULT_QUEUE.to_s
      obj.send(:env).should include 'COUNT' => count.to_s
      obj.send(:cmd).should include Guard::Resque::DEFAULT_TASK_MULTIPLE
    end

  end
end
