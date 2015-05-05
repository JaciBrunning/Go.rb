# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'go/version'

Gem::Specification.new do |spec|
  spec.name          = "Go.rb"
  spec.version       = Go::VERSION
  spec.authors       = ["JacisNonsense"]
  spec.email         = ["jaci.brunning@gmail.com"]

  spec.summary       = %q{The features of the 'Go' language without the weird syntax}
  spec.description   = %q{'Go' is a language that specializes in concurrency and control flow, but some people (myself included) don't like the choice of Syntax. Not only that, but these features are something that could be useful in other projects, hence why I created 'GoRuby', bringing the Concurrency and Control Flow features of 'Go' into Ruby}
  spec.homepage      = "http://www.github.com/JacisNonsense/go.rb"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.bindir        = "bin"
  spec.files = Dir.glob("lib/**/*") + ['Rakefile', 'goruby.gemspec', 'Gemfile', 'Rakefile']
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "coveralls"
end
