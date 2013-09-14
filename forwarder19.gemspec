$:.unshift( File.expand_path( "../lib", __FILE__ ) )
require 'forwarder/version'
Gem::Specification.new do |s|
  s.name        = 'forwarder19'
  s.version     = Forwarder::VERSION 
  s.summary     = "Delegation And AOP Filters For It"
  s.description = %{Ruby's core Forwardable gets the job done(barely) and produces most unreadable code. 

  Forwarder19 not only is more readable, much more feature rich, but also slightly faster, meaning you can use it without performance penalty.

  Additional features include: providing arguments, (partially if needed), AOP and custom forwarding to hashes
  }

  s.authors     = ["Robert Dober"]
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob("lib/**/*.rb")
  s.files      += %w{LICENSE README.md}
  s.homepage    = 'https://github.com/RobertDober/Forwarder19'
  s.licenses    = %w{MIT}

  s.add_dependency 'lab419_core', '~> 0.0.3'

  s.add_development_dependency 'pry', '~> 0.9'

  s.add_development_dependency 'rspec', '~> 2.9.0'

  s.required_ruby_version = '>= 1.9.3'
end
