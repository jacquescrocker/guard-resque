# Guard::Delayed

Guard::Delayed automatically starts/stops/restarts delayed_job

## Install

Please be sure to have [Guard](http://github.com/guard/guard) installed before continue.

Install the gem:

    gem install guard-delayed

Add it to your Gemfile (inside test group):

    gem 'guard-delayed'

Add guard definition to your Guardfile by running this command:

    guard init delayed

## Usage

Please read [Guard usage doc](http://github.com/guard/guard#readme).

I suggest you put your guard definition for delayed_job *before* your tests, if your tests depend on it
being active.

## Guardfile

    guard 'delayed' do
      watch()
    end

## Development

* Source hosted at [GitHub](http://github.com/suranyami/guard-delayed)
* Report issues/Questions/Feature requests on [GitHub Issues](http://github.com/suranyami/guard-delayed/issues)

Pull requests are very welcome! Make sure your patches are well tested. Please create a topic branch for every separate change
you make.

== Authors

[David Parry](http://github.com/suranyami)

This gem is based on [Guard::WEBrick](http://github.com/fnichol/guard-webrick).
