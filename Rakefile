require 'rubygems'
require 'rake/gempackagetask'
require 'spec/rake/spectask'

desc "Run all specs in spec directory"  
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end

spec = Gem::Specification.new do |s| 
  s.name = "gimme"
  s.version = "0.0.1"
  s.author = "Pete Hodgson"
  s.email = "gimme@thepete.net"
  s.homepage = "http://github.com/moredip/gimme"
  s.platform = Gem::Platform::RUBY
  s.summary = "A lightweight implementation of the Registry pattern, wrapped in a pretty DSL bow."
#  s.files = FileList["lib/**/*"].to_a
  s.files = 'gimmme.rb'
  s.require_path = "lib"
  s.autorequire = "gimme"
  s.test_files = FileList["{spec}/**/*_spec.rb"].to_a
  s.has_rdoc = false
  s.extra_rdoc_files = ["README"]
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end 

