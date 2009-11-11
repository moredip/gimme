require 'gimme'

class Logger
  def initialize( threshold )
    puts "creating a logger with a threshold of #{threshold}"
  end
end


Gimme.configure do |g|
  g.for_a( :logger ) do |env|
    Logger.new( env[:logging_threshold] )
  end
end

Gimme.environment = {:logging_threshold => :INFO}


logger = Gimme.a(:logger)
