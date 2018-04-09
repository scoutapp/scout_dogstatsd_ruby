require_relative 'test_helper'

class TransactionCallbackTest < Minitest::Test
  def setup
    statsd = Datadog::Statsd.new('localhost')
    statsd.socket = FakeUDPSocket.new
    ScoutDogstatsd.configure(statsd)
  end

  def test_call
    callback = ScoutDogstatsd::TransactionCallback.new(converter_results,context,scope_layer)
    callback.call # would be great to validate the actual statsd metrics that are reported
  end

  private

  def context
    ScoutApm::Context.new(ScoutApm::AgentContext.new)
  end

  def scope_layer
    scope_layer = ScoutApm::Layer.new('Controller', 'users/index', Time.now - 0.1)
    scope_layer.record_stop_time!(Time.now)
    scope_layer
  end

  def converter_results
    meta = ScoutApm::MetricMeta.new("Controller/uesrs/index")
    stats = ScoutApm::MetricStats.new
    stats.update!(0.1)
    {
     :metrics => {meta => stats},
     :errors=>nil, 
     :queue_time=>nil, 
     :job=>nil
    }
  end
end