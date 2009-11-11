require 'singleton'

class Gimme

  include Singleton

  class << self
    def configure
      instance.reset
      yield instance
      instance
    end

    def a(*args)
      instance.build_a(*args)
    end
    alias the a

    def environment=(env)
      instance.environment=(env)
    end
  end

  attr_writer :environment

  def initialize
    reset
  end

  def reset
    @construction_specs = {}
  end

  def add_construction_spec( label, &proc)
    label = stringify_label(label)
    @construction_specs[label] = proc
  end
  alias :for_a :add_construction_spec

  def build_a(label, *args)
    label = stringify_label(label)
    raise "Don't know how to bulid a #{label}" unless @construction_specs.has_key?(label)
    
    @construction_specs[label].call( @environment, *args )
  end

  def inspect
    @construction_specs.keys.join("\n")
  end

  private

  def stringify_label(label)
    label.to_s
  end

end



#TODO: support label being a class name