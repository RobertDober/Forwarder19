$:.unshift( File.expand_path( "../lib", __FILE__ ) )
require 'forwarder/version'
Gem::Specification.new do |s|
  s.name        = 'forwarder19'
  s.version     = Forwarder::VERSION 
  s.summary     = "Delegation And AOP Filters For It"
  s.description = %{Ruby's core Forwardable gets the job done(barely) and produces most unreadable code. Furthermore it is about twice as slow (1.9.2-p290) or thrice as slow (1.9.3-p0) as it needs to be.

This is a nonintrusive (as is Forwardable) module that allows to delegate methods to instance variables,
objects returned by instance_methods, other methods of the same receiver, the receiver itself, a chain of messages or
an arbitrary object. Paramters can be provided in the forwarding definition (parially or totally=.
It also defines some AOP support as after and before filters.

Performance will be pushed to 2~3 times of Fowardable with the 0.2 branch of this gem}
  s.authors     = ["Robert Dober"]
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob("lib/**/*.rb")
  s.files      += %w{LICENSE README.md}
  s.homepage    = 'https://github.com/RobertDober/Forwarder19'
  s.licenses    = %w{MIT}

  s.add_dependency 'lab419_core', '~> 0.0.1'

  s.add_development_dependency 'ruby-debug19', '~> 0.11'

  s.add_development_dependency 'rake', '~> 0.9.2.2'
  s.add_development_dependency 'rspec', '~> 2.9.0'
  s.add_development_dependency 'maruku', '~> 0.6.0'
  s.add_development_dependency 'wirble', '~> 0.1.3'

  s.required_ruby_version = '>= 1.9.2'
end
