require 'rubygems'
require 'rake/gempackagetask'
require 'spec/rake/spectask'

desc "Run all specs in spec directory"  
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end

spec = Gem::Specification.new do |s| 
  s.name = "gimme"
  s.version = "0.0.3"
  s.author = "Pete Hodgson"
  s.email = "gimme@thepete.net"
  s.homepage = "http://github.com/moredip/gimme"
  s.platform = Gem::Platform::RUBY
  s.summary = "A lightweight implementation of the Registry pattern, wrapped in a pretty DSL bow."
	s.description = "A simple implementation of a Registry, along with a cute DSL to configure and use it. You tell Gimme how to create the well-known objects in your system. Then whenever you need an instance of one of those objects you just ask Gimme for one."
  s.files = 'gimme.rb'
  s.test_files = FileList["{spec}/**/*_spec.rb"].to_a
  s.has_rdoc = false
  s.extra_rdoc_files = ["README.md"]
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end 

