require 'guard'
require 'guard/guard'

module Guard
  class Delayed < Guard

    def initialize(watchers = [], options = {})
      super
    end

    def start
      UI.info "Starting up delayed_job..."
      system('script/delayed_job', 'start')
    end

    # Called on Ctrl-C signal (when Guard quits)
    def stop
      UI.info "Starting up delayed_job..."
      system('script/delayed_job', 'stop')
    end

    # Called on Ctrl-Z signal
    # This method should be mainly used for "reload" (really!) actions like reloading passenger/spork/bundler/...
    def reload
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
      system('script/delayed_job', 'restart')
    end
  end
end
