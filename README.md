# Gimme
A simple implementation of a Registry, along with a cute DSL to configure and use it. You tell Gimme how to create the well-known objects in your system. 
Then whenever you need an instance of one of those objects you just ask Gimme for one.

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


## Configuration

Use the Gimme.configure block to configure Gimme with information on how to create the well-known objects you want to be available in your registry. 
You can configure singletons using for_the() and Non-singletons using for_a(). Gimme will squirrel away the block supplied to those methods and then use it
later on when it's asked for an instance of that object.

## Use 

Ask Gimme for an object by calling Gimme.the or Gimme.a, for singletons and non-singletons respectively. As you'd expect, Gimme calls the creation block each time
a non-singleton is requested, and only once when a singleton is requested. Subsequent requests for the singleton will simply return the object created the first time the
singleton's creation block was called.

## Environments
You can supply Gimme with an environment hash, which generally contains application settings, For example you might add email server settings or api keys to your environment.
When Gimme creates objects it passes the environment hash to the creation block. You can use that feature to configure the objects created with Gimme.

## Dependency Injection/Inversion of Control
You can use Gimme as a lightweight IoC container. There is nothing to stop you calling Gimme.the() or Gimme.a() from inside a Gimme creation block. Check out the 
di_example.rb file in the examples directory for more inspiration.
