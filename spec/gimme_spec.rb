require File.expand_path(File.join(File.dirname(__FILE__), "/spec_helper"))
require File.expand_path(File.join(File.dirname(__FILE__), "/../gimme"))

describe Gimme do
 
  specify "Gimme#a for singletons should return the same instance each time it is called" do
    Gimme.configure do |g|
      for_the(:singleton) do Object.new; end
    end
    first_object = Gimme.a(:singleton)
    second_object = Gimme.a(:singleton)
    first_object.object_id.should == second_object.object_id
  end

  specify "Gimme#a for regular objects should return a different instance each time it is called" do
    Gimme.configure do |g|
      for_a(:regular_object) do Object.new; end
    end
    first_object = Gimme.a(:regular_object)
    second_object = Gimme.a(:regular_object)
    first_object.object_id.should_not == second_object.object_id
  end


  specify 'Gimme#a should raise a NotFoundError if nothing with that label has been configured' do
    Gimme.configure do |g|
    end
    
    lambda{
      Gimme.a(:unknown_thing)
    }.should raise_error(Gimme::NotFoundError)
  end 

	specify 'additional arguments are passed to creation block' do
		Gimme.configure do |g|
			for_a(:arguments_echo) do |env,*args|
				args
			end
		end

		Gimme.a(:arguments_echo,'a',:b,3).should == ['a',:b,3]
		Gimme.a(:arguments_echo).should == []
	end

end
