require 'gimme'

# your Emailer class

class Emailer
  def initialize( smtp_hostname, port )
    @smtp_hostname, @port = smtp_hostname, port
    puts "creating an emailer: #{inspect}"
  end

  def send_email( subject )
    puts "Sending email '#{subject}' via #{inspect}"
    # ...
  end

  def inspect
    "#{@smtp_hostname}:#{@port}"
  end
end


# your Gimme configuration

Gimme.configure do |g|
  g.for_the( Emailer ) do |env|
    email_settings = env[:email_settings]
    Emailer.new(email_settings[:hostname],email_settings[:port])
  end
end

Gimme.environment = {:email_settings => {:hostname => 'smtp.mymailserver.com', :port => '2525'} }



# in your app


Gimme.the(Emailer).send_email( "Gimme is the awesomez" )
Gimme.the(Emailer).send_email( "Emailing is fun" )
Gimme.the(Emailer).send_email( "notice that only one Emailer was created above" )
Gimme.the(Emailer).send_email( "even though we sent 4 emails" )
