require 'gimme'

module Logging
  class DatabaseSink
    def write_log_entry( level, message )
      # ...
    end
  end

  class SyslogSink
    def write_log_entry( level, message )
      # ...
    end
  end

  class StdOutSink
    def write_log_entry( level, message )
      # ...
    end
  end

  class Logger
    def initialize(sink)
      puts "Creating logger which will output using a #{sink.class}"
      @sink = sink
    end

    def log(message)
      # ... write log entry to @sink
    end
  end
end



Gimme.configure do |g|
  g.for_a(:logger) do |env,*args|
    sink_class = env[:logging][:sink]
    Logging::Logger.new( sink_class.new )
  end
end


Gimme.environment = {
 :logging => {:sink => Logging::SyslogSink}
}

Gimme.a(:logger).log('some logging')
