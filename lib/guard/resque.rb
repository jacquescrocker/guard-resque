require 'guard'
require 'guard/guard'

module Guard
  class Resque < Guard

    # Allowable options are:
    # :environment  e.g. 'test'
    # :task .e.g 'resque:work'
    # :queue e.g. '*'
    # :count e.g. 3
    # :verbose e.g. true
    # :trace e.g. true
    # :stop_signal e.g. KILL
    def initialize(watchers = [], options = {})
      @options = options
      @pid = nil
      @stop_signal = options[:stop_signal] || "KILL"
      super
    end

    def start
      stop
      UI.info "Starting up resque..."
      UI.info cmd
      @pid = spawn(cmd)
    end

    # Called on Ctrl-C signal (when Guard quits)
    def stop
      if @pid
        UI.info("Stopping resque...")
        ::Process.kill(@stop_signal, @pid)
        ::Process.waitpid(@pid) rescue Errno::ESRCH
        @pid = nil
        UI.info("Stopped process resque")
      end
    end

    # Called on Ctrl-Z signal
    # This method should be mainly used for "reload" (really!) actions like reloading passenger/spork/bundler/...
    def reload
      UI.info "Restarting resque..."
      restart
    end

    # Called on Ctrl-/ signal
    # This method should be principally used for long action like running all specs/tests/...
    def run_all
      true
    end

    # Called on file(s) modifications
    def run_on_change(paths)
      restart
    end

    def restart
      stop
      start
    end

    private

    def cmd
      command = "bundle exec rake "

      # environment setting
      command << "RAILS_ENV=#{@options[:environment]} " if @options[:environment]

      # queue setting
      command << "QUEUE=#{@options[:queue] || '*'} "

      #count setting
      command << "COUNT=#{@options[:count] || '1'} "

      # verbose setting
      command << "VVERBOSE=1 " if @options[:verbose]

      # task setting
      command << "#{@options[:task] || 'resque:work'} "

      # trace setting
      command << "--trace " if @options[:trace]

      command
    end
  end
end
