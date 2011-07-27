require 'guard'
require 'guard/guard'

module Guard
  class Delayed < Guard
    
    # Allowable options are:
    # :environment  e.g. 'test'
    # :min_priority e.g. 2
    # :max_priority e.g. 10
    # :number_of_workers e.g. 2
    # :pid_dir  e.g. tmp/pids Specifies an alternate directory in which to store the process ids.
    # :identifier     A numeric identifier for the worker.
    # :monitor                    Start monitor process.
    # :sleep-delay N              Amount of time to sleep in seconds when no jobs are found
    # :prefix NAME                String to be prefixed to worker process names
    
    def initialize(watchers = [], options = {})
      @options = options
      super
    end

    def start
      system(cmd, 'stop')
      UI.info "Starting up delayed_job..."
      args = "start"
      args << " --min-priority #{@options[:min_priority]}" if @options[:min_priority]
      args << " --max-priority #{@options[:max_priority]}" if @options[:max_priority]
      args << " --number_of_workers=#{@options[:number_of_workers]}" if @options[:number_of_workers]
      args << " --pid-dir=#{@options[:pid_dir]}" if @options[:pid_dir]
      args << " --identifier=#{@options[:identifier]}" if @options[:identifier]
      args << " --monitor" if @options[:monitor]
      args << " --sleep-delay #{@options[:sleep_delay]}" if @options[:sleep_delay]
      args << " --prefix #{@options[:prefix]} " if @options[:prefix]
      system(cmd, args)
    end

    # Called on Ctrl-C signal (when Guard quits)
    def stop
      UI.info "Stopping delayed_job..."
      system(cmd, 'stop')
    end

    # Called on Ctrl-Z signal
    # This method should be mainly used for "reload" (really!) actions like reloading passenger/spork/bundler/...
    def reload
      UI.info "Restarting delayed_job..."
      restart
    end

    # Called on Ctrl-/ signal
    # This method should be principally used for long action like running all specs/tests/...
    def run_all
      restart
    end

    # Called on file(s) modifications
    def run_on_change(paths)
      restart
    end
    
    private
    
    def restart
      system(cmd, 'restart')
    end
    
    def cmd
      command = "script/delayed_job"
      command = "RAILS_ENV=#{@options[:environment]} #{command}" if @options[:environment]
      command
    end
  end
end
