class GimmeConfigurator
  def initialize
    @singleton_scope = {}
    @no_scope = {}
  end

  def build_gimme
    Gimme.new( @singleton_scope, @no_scope )
  end

  def for_a(label,&proc)
    register_builder( @no_scope, label, proc )
  end

  def for_the(label,&proc)
    register_builder( @singleton_scope, label, proc )
  end

  private

  def register_builder( store, key, proc )
    store[key] = proc
  end

end
