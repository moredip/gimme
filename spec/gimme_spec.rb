require File.expand_path(File.join(File.dirname(__FILE__), "/spec_helper"))
require File.expand_path(File.join(File.dirname(__FILE__), "/../gimme"))

describe Gimme do
 
  specify "Gimme#the should return the same instance each time it is called" do
    Gimme.configure do |g|
      g.for_the(:singleton) do Object.new; end
    end
    first_object = Gimme.the(:singleton)
    second_object = Gimme.the(:singleton)
    first_object.object_id.should == second_object.object_id
  end

  specify 'Gimme#a should raise a NotFoundError if nothing with that label has been configured' do
    Gimme.configure do |g|
    end
    
    lambda{
      Gimme.a(:unknown_thing)
    }.should raise_error(Gimme::NotFoundError)
  end 

  specify 'Gimme#a should raise a NotFoundError if that label has only been configured for a singleton' do
    Gimme.configure do |g|
      g.for_the(:singleton) do Object.new; end
    end
    
    lambda{
      Gimme.a(:singleton)
    }.should raise_error(Gimme::NotFoundError)
  end 

  specify 'Gimme#the should raise a NotFoundError if that label has only been configured for a regular object' do
    Gimme.configure do |g|
      g.for_a(:object) do Object.new; end
    end
    
    lambda{
      Gimme.the(:object)
    }.should raise_error(Gimme::NotFoundError)
  end 


end
