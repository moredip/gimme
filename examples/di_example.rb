require 'gimme'

# allows a client to access memcache
class Memcache
  def initialize( host, port )
    puts "creating a connection to a memcached instance at #{host}:#{port}"
  end

  # ...
end

# allows a client to access a geocoding web service
# optionally caching the results in memcache
class GeocodeGateway
  def initialize( url, memcache )
    puts "creating a gateway to the geocoding service at #{url}"
  end

  def get_coordinates_for_zip( zip )
    # check for result in memcache, fetch from remote service if not present in memcache, cache result
  end

  # ...
end


Gimme.configure do |g|
  g.for_a( Memcache ) do |env|
    Memcache.new( env[:memcache][:host], env[:memcache][:port] )
  end
 
  g.for_a( GeocodeGateway ) do |env|
    GeocodeGateway.new( env[:geocode_service_url], Gimme.the(Memcache) )
  end
end

Gimme.environment = { 
  :memcache=>{:host=>'localhost',:port=>'11211'},
  :geocode_service_url => "http://www.geocode.com/services"
}

Gimme.the(GeocodeGateway).get_coordinates_for_zip( "90210" )
