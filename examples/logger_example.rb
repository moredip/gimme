require 'gimme'

class Logger
  def initialize( threshold, name )
    puts "creating a logger called #{name} with a threshold of #{threshold}"
  end
end


Gimme.configure do |g|
  g.for_a( :logger ) do |env,*args|
    Logger.new( env[:logging_threshold], *args )
  end
end

Gimme.environment = {:logging_threshold => :INFO}


logger = Gimme.a(:logger,'Dave')
