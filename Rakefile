require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec

namespace(:spec) do
  desc "Run all specs on multiple ruby versions (requires rvm)"
  task(:portability) do
    rubies = if ENV['RUBIES']
               ENV['RUBIES'].split(' ')
             else
               %w[1.8.7 1.9.2 ree jruby]
             end
    rubies.each do |version|
      rvm_ruby = if ENV['GEMSET']
                   "#{version}@#{ENV['GEMSET']}"
                 else
                   version
                 end
      system <<-BASH
        bash -c '
          source ~/.rvm/scripts/rvm;
          rvm #{rvm_ruby};
          echo "--------- version #{rvm_ruby} ----------\n";
          bundle install;
          rake spec'
      BASH
    end
  end
end
