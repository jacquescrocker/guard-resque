# Guard::DelayedJob

Guard::DelayedJob automatically starts/stops/restarts delayed_job

## Install

Please be sure to have [Guard](http://github.com/guard/guard) installed before continue.

Install the gem:

    gem install guard-delayed_job

Add it to your Gemfile (inside test group):

    gem 'guard-delayed_job'

Add guard definition to your Guardfile by running this command:

    guard init delayed_job

## Usage

Please read [Guard usage doc](http://github.com/guard/guard#readme).

I suggest you put your guard definition for delayed_job *before* your tests, if your tests depend on it
being active.

## Guardfile

    guard 'delayed_job' do
      watch()
    end

## Development

* Source hosted at [GitHub](http://github.com/suranyami/guard-delayed_job)
* Report issues/Questions/Feature requests on [GitHub Issues](http://github.com/suranyami/guard-delayed_job/issues)

Pull requests are very welcome! Make sure your patches are well tested. Please create a topic branch for every separate change
you make.

== Authors

[David Parry](http://github.com/suranyami)
