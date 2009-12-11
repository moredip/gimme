require File.expand_path(File.join(File.dirname(__FILE__), "/spec_helper"))
require File.expand_path(File.join(File.dirname(__FILE__), "/../gimme"))

describe 'gimme configuration' do
  specify 'configure should return the Gimme instance' do
    g = Gimme.configure do
    end
    g.should == Gimme.instance
  end

  specify 'Gimme#a should return a different instance each time it is called' do
    Gimme.configure do |g|
      for_a(:object) do Object.new; end
    end
    first_object = Gimme.a(:object)
    second_object = Gimme.a(:object)
    first_object.object_id.should_not == second_object.object_id
  end

  specify "Gimme#the should return the object it is configured to return" do
    the_singleton = Object.new
    Gimme.configure do |g|
      for_the(:singleton) do the_singleton end
    end
    Gimme.the(:singleton).object_id.should == the_singleton.object_id
  end
end
