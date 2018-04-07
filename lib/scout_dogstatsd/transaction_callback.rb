module ScoutDogstatsd
  class TransactionCallback < ScoutApm::Extensions::TransactionCallbackBase
    def call
      ScoutDogstatsd.client.batch do |s|
        s.histogram("#{transaction_type_slug}.duration_ms", duration_ms, :tags => tags)

        if queue_time_ms
          s.gauge("#{transaction_type_slug}.queue_time_ms", queue_time_ms, :tags => tags)
        end

        if error?
          s.increment("#{transaction_type_slug}.error_count", :tags => tags)
        end
      end
    end

    private

    def tags
      [
        "hostname:#{hostname}",
        "app:#{app_name}",
      ]
    end

    # Renames Scout metric names to a more StatsD-ish format. 
    # Ex: Controllers/users/index => users.index
    def transaction_name
      transaction_name
        .sub!(/\A\w+\//,'') # remove the type (Controller, Job)
        .gsub("/",".")    
    end
  end
end