require 'guard'
require 'guard/guard'

module Guard
  class Resque < Guard

    # Allowable options are:
    # :environment  e.g. 'test'
    # :task .e.g 'resque:work'
    # :queue e.g. '*'
    # :verbose e.g. true
    # :trace e.g. true
    # :stop_signal e.g. KILL
    def initialize(watchers = [], options = {})
      @options = options
      @process = nil
      @pid = nil
      @stop_signal = options[:stop_signal] || "TERM"
      super
    end

    def start
      stop
      UI.info "Starting up resque..."
      @process = IO.popen(cmd)
      @pid = @process.pid
    end

    # Called on Ctrl-C signal (when Guard quits)
    def stop
      if @process
        UI.info("Stopping resque...")
        ::Process.kill(@stop_signal, @process.pid)
        ::Process.waitpid(@pid) rescue Errno::ESRCH
        @process.close
        @pid = nil
        UI.info("Stopped process #{@name}")
      end
    end

    # Called on Ctrl-Z signal
    # This method should be mainly used for "reload" (really!) actions like reloading passenger/spork/bundler/...
    def reload
      UI.info "Restarting resque..."
      stop
      start
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

    private

    def cmd
      command = "bundle exec rake "

      # environment setting
      command << "RAILS_ENV=#{@options[:environment]} " if @options[:environment]

      # queue setting
      command << "QUEUE=#{@options[:queue] || '*'} "

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
