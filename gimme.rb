require 'gimme_configurator'

class Gimme

  class NotFoundError < RuntimeError
    def initialize( label )
      super( "Have not been configured to supply a #{label}" )
    end
  end
  class << self
    attr_reader :instance
   
    def configure(&block)
      configurator = GimmeConfigurator.new
      configurator.instance_eval &block
      @instance = configurator.build_gimme
      instance
    end

    def a(*args)
      instance.build_a(*args)
    end

    def the(*args)
      instance.build_the(*args)
    end    

    def environment=(env)
      instance.environment=(env)
    end
  end

  attr_writer :environment

  def initialize( singleton_scope = {}, no_scope = {} )
    @singletons = singleton_scope
    @regular_objects = no_scope
  end

  def reset
    @regular_objects = {}
    @singletons = {}
  end

  def for_a(label,&proc)
    add_builder( @regular_objects, label, proc )
  end

  def for_the(label,&proc)
    add_builder( @singletons, label, proc )
  end

  def build_a(label, *args)
    raise NotFoundError.new( label ) unless @regular_objects.has_key?(label)
    
    @regular_objects[label].call( @environment, *args )
  end

  def build_the(label, *args)
    raise NotFoundError.new( label ) unless @singletons.has_key?(label)

    if @singletons[label].is_a?( Proc )
      @singletons[label] = @singletons[label].call( @environment, *args )
    end 
    
    @singletons[label]
  end

  def inspect
    <<EOS
Regular builders for #{@regular_objects.keys.inspect}
Singleton builders for #{@singletons.keys.inspect}
EOS
  end

  private

  def add_builder( builder_hash, label, proc)
    label = stringify_label(label)
    builder_hash[label] = proc
  end

  def stringify_label(label)
    case label
    when Module then
      label.name
    else
      label.to_s
    end
  end

end 
