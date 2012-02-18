require 'guard'
require 'guard/guard'

module Guard
  class Resque < Guard

    DEFAULT_SIGNAL = :QUIT
    DEFAULT_QUEUE = '*'.freeze
    DEFAULT_COUNT = 1
    DEFAULT_TASK_SINGLE = 'resque:work'.freeze
    DEFAULT_TASK_MULTIPLE = 'resque:workers'.freeze

    # Allowable options are:
    #  - :environment  e.g. 'test'
    #  - :task .e.g 'resque:work'
    #  - :queue e.g. '*'
    #  - :count e.g. 3
    #  - :verbose e.g. true
    #  - :vverbose e.g. true
    #  - :trace e.g. true
    #  - :stop_signal e.g. :QUIT or :SIGQUIT
    def initialize(watchers = [], options = {})
      @options = options
      @pid = nil
      @stop_signal = options[:stop_signal] || DEFAULT_SIGNAL
      @options[:queue] ||= DEFAULT_QUEUE
      @options[:count] ||= DEFAULT_COUNT
      @options[:task] ||= (@options[:count].to_i == 1) ? DEFAULT_TASK_SINGLE : DEFAULT_TASK_MULTIPLE
      super
    end

    def start
      stop
      UI.info 'Starting up resque...'
      UI.info [ cmd, env.map{|v| v.join('=')} ].join(' ')

      # launch Resque worker
      @pid = spawn(env, cmd)
    end

    def stop
      if @pid
        UI.info 'Stopping resque...'
        ::Process.kill @stop_signal, @pid
        begin
          Timeout.timeout(15) do
            ::Process.wait @pid
          end
        rescue Timeout::Error
          UI.info 'Sending SIGKILL to resque, as it\'s taking too long to shutdown.'
          ::Process.kill :KILL, @pid
          ::Process.wait @pid
        end
        UI.info 'Stopped process resque'
      end
    rescue Errno::ESRCH
      UI.info 'Guard::Resque lost the Resque worker subprocess!'
    ensure
      @pid = nil
    end

    # Called on Ctrl-Z signal
    def reload
      UI.info 'Restarting resque...'
      restart
    end

    # Called on Ctrl-/ signal
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
      command = ['bundle exec rake', @options[:task].to_s]

      # trace setting
      command << '--trace' if @options[:trace]

      return command.join(' ')
    end

    def env
      var = Hash.new

      var['QUEUE']     = @options[:queue].to_s       if @options[:queue]
      var['COUNT']     = @options[:count].to_s       if @options[:count]
      var['RAILS_ENV'] = @options[:environment].to_s if @options[:environment]

      var['VERBOSE']  = '1' if @options[:verbose]
      var['VVERBOSE'] = '1' if @options[:vverbose]

      return var
    end
  end
end
