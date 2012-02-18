# Guard::Resque

Guard::Resque automatically starts/stops/restarts resque workers

*forked from [Guard::Delayed](http://github.com/suranyami/guard-delayed)*

## Install

Please be sure to have [Guard](http://github.com/guard/guard) installed before continue.

Install the gem:

    gem install guard-resque

Add it to your Gemfile (inside test group):

    gem 'guard-resque'

Add guard definition to your Guardfile by running this command:

    guard init resque

## Usage

Please read [Guard usage doc](http://github.com/guard/guard#readme).

I suggest you put the resque guard definition *before* your test/rspec guard if your tests depend on it
being active.

## Guardfile

    guard 'resque', :environment => 'development' do
      watch(%r{^app/(.+)\.rb})
    end

## Options

You can customize the resque task via the following options:

* `environment`: the rails environment to run the workers in (defaults to `nil`)
* `task`: the name of the rake task to use (defaults to `"resque:work"`)
* `queue`: the resque queue to run (defaults to `"*"`)
* `count`: the number of workers to include (defaults to `1`)
* `verbose`: whether to use verbose logging (defaults to `nil`)
* `vverbose`: whether to use very verbose logging (defaults to `nil`)
* `trace`: whether to include `--trace` on the rake command (defaults to `nil`)
* `stop_signal`: how to kill the process when restarting (defaults to `QUIT`)


## Development

 * Source hosted at [GitHub](http://github.com/railsjedi/guard-resque)
 * Report issues/Questions/Feature requests on [GitHub Issues](http://github.com/railsjedi/guard-resque/issues)

Pull requests are very welcome! Make sure your patches are well tested. Please create a topic branch for every separate change
you make.

## Testing the gem locally

    gem install guard-resque-0.x.x.gem

## Building and deploying gem

 * Update the version number in `lib/guard/resque/version.rb`
 * Update `CHANGELOG.md`
 * Build the gem:

    gem build guard-resque.gemspec

 * Push to rubygems.org:

    gem push guard-resque-0.x.x.gem


## Guard::Delayed Authors

[David Parry](https://github.com/suranyami)
[Dennis Reimann](https://github.com/dbloete)

Ideas for this gem came from [Guard::WEBrick](http://github.com/fnichol/guard-webrick).


## Guard::Resque Authors

[Jacques Crocker](https://github.com/railsjedi)

I hacked this together from the `guard-delayed` gem for use with Resque. All credit go to the original authors though. I just search/replaced and tweaked a few things


