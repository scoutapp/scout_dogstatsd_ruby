require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'
require 'mocha/mini_test'

require 'scout_apm'
require 'datadog/statsd'
require 'scout_dogstatsd'

class Datadog::Statsd
  # we need to stub this
  attr_accessor :socket
end

class FakeUDPSocket
  def initialize
    @buffer = []
  end

  def send(message, *)
    @buffer.push [message]
  end

  def recv
    @buffer.shift
  end

  def to_s
    inspect
  end

  def inspect
    "<FakeUDPSocket: #{@buffer.inspect}>"
  end
end


