# Forwarder19

This implementation is for, and needs Ruby 1.9.2 or later. For Ruby 1.8.7 please see https://github.com/RobertDober/Forwarder.

## Abstract

Ruby's core Forwardable gets the job done(barely) and produces most unreadable code.
This is a nonintrusive (as is Forwardable) module that allows to delegate methods to instance variables,
objects returned by instance_methods, other methods of the same receiver, the receiver itself, a chain of messages or
an arbitrary object. Paramters can be provided in the forwarding definition (parially or totally=.
It also defines after and before filters.  and some more sophisticated use cases}
