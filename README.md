# ScoutDogstatsd

Want your Rails performance KPIs in your DogStatsD-compatible metric system with _almost_ zero effort? Of course you do! Meet `scout_dogstatsd`! This gem is an extension of the [Scout](https://scoutapp.com) Ruby monitoring agent, sending the following metrics w/o any custom instrumentation steps:

* web.duration_ms (histogram) - The total duration of web requests in milliseconds
* job.duration_ms (histogram) - The total duration of background jobs (Sidekiq, DelayedJob, etc.) in milliseconds
* web.error_count (counter) - A count of web requests that throw an exception
* job.error_count (counter) - A count of background jobs that throw an exception
* web.queue_time_ms (gauge) - The [time spent in request queuing](http://help.apm.scoutapp.com/#request-queuing) in milliseconds
* job.queue_time_ms (gauge) - The time between when a job is inserted into a background job queue and when execution begins in milliseconds

These metrics are tagged too! Slice and dice! The following tags are added to each metric:

* app - The name of the app. See the [name](http://help.apm.scoutapp.com/#name) Scout config option.
* hostname - The hostname of the app. See the [hostname](http://help.apm.scoutapp.com/#hostname) Scout config option.

A [Scout](https://scoutapp.com) account isn't required, but it certainly makes getting to the source of app performance easier 😉.

Now, you can correlate app performance metrics to all of your other system metrics.

![screen](https://s3-us-west-1.amazonaws.com/scout-blog/scout_dogstatsd/datadog_screen.png)

## Monitoring Platforms that Support the DogStatsD Protocol

* DataDog
* SignalFx via the [collectd dogstatsd plugin](https://github.com/signalfx/signalfx-collectd-plugin/blob/master/src/dogstatsd.py)
* Prometheus via the [statsd exporter](https://github.com/prometheus/statsd_exporter)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'scout_dogstatsd'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scout_dogstatsd

## Configuration

### 1. Add a `config/initializers/scout_dogstatsd.rb` file to your Rails app:

```ruby
require 'datadog/statsd'
statsd = Datadog::Statsd.new('localhost', 8125)
ScoutDogstatsd.configure(statsd)
```

### 2. Add a `config/scout_apm.yml` file to your Rails app:

```yaml
common: &defaults
  monitor: true

development:
  <<: *defaults
  monitor: false # set to true to test in your development environment

production:
  <<: *defaults
```

__Metrics are only sent if `monitor: true` for the associated Rails environment.__

[See the Scout docs](http://help.apm.scoutapp.com/#ruby-agent) for advanced configuration instructions.

## How it works

After each transaction (a web request or background job), the metrics specific to that transaction are transmitted via the DogStatsD protocol via the client passed through to `ScoutDogstatsd#configure`. The `scout_apm` gem automatically instruments Rails controller-actions, so no code changes are required. Easy peasy!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/scoutapp/scout_dogstatsd_ruby.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

