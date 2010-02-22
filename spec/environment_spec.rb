require File.expand_path(File.join(File.dirname(__FILE__), "/spec_helper"))
require File.expand_path(File.join(File.dirname(__FILE__), "/../gimme"))

describe 'gimme environment' do

	SOME_ENVIRONMENT_HASH = {
		:one => 2,
		:buckle => [:my, :shoe]
	}

  before :each do
		Gimme.configure do |g|
      for_a(:environment_echo) do |env,*args|
				env
			end
    end
	end

  it "passes the contents of the configured gimme environment to the creation block" do
		Gimme.environment = SOME_ENVIRONMENT_HASH
		Gimme.a(:environment_echo).should == SOME_ENVIRONMENT_HASH
  end

  it "has an empty environment hash by default" do
		Gimme.a(:environment_echo).should == {}
	end
end
