module ScoutDogstatsd
  class TransactionCallback
    def call(payload)
      @payload = payload
      ScoutDogstatsd.client.batch do |s|
        s.histogram("#{payload.transaction_type_slug}.duration_ms", payload.duration_ms, :tags => tags)

        if payload.queue_time_ms
          s.gauge("#{payload.transaction_type_slug}.queue_time_ms", payload.queue_time_ms, :tags => tags)
        end

        if payload.error?
          s.increment("#{payload.transaction_type_slug}.error_count", :tags => tags)
        end
      end
    end

    private

    def tags
      [
        "hostname:#{@payload.hostname}",
        "app:#{@payload.app_name}",
      ]
    end

  end
end