require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec

namespace :spec do
  desc "Run all specs on multiple ruby versions (requires rvm)"
  task :portability do

    command = <<-BASH
      source ~/.rvm/scripts/rvm;
      rvm #{ENV['RUBIES'] || 'all'} do bundle exec rake spec
    BASH
    system "bash -c '#{command}'"

  end

  namespace :portability do
    desc 'Installs bundler/rake and runs bundle install for all rubies'
    task :prepare do
      # FIXME: This isn't working for me when it gets to JRuby, specs are running fine - RL
      command = <<-BASH
        source ~/.rvm/scripts/rvm;
        rvm #{ENV['RUBIES'] || 'all'} do gem install bundler rake;
        rvm #{ENV['RUBIES'] || 'all'} do bundle install
      BASH

      system "bash -c '#{command}'"
    end
  end
end
