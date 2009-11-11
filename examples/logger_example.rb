require 'gimme'

class Logger
  def initialize( threshold, name )
    puts "creating a logger called #{name} with a threshold of #{threshold}"
  end
end


Gimme.configure do |g|
  g.for_a( Logger ) do |env, name|
    name ||= 'default'
    Logger.new( env[:logging_threshold], name )
  end
end

Gimme.environment = {:logging_threshold => :INFO}


default_logger = Gimme.a(Logger)
dave_logger = Gimme.a(Logger,'Dave')
