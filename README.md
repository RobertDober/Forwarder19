# Forwarder19

This implementation is for, and needs Ruby 1.9.2 or later. For Ruby 1.8.7 please see https://github.com/RobertDober/Forwarder.

## Abstract

Ruby's core Forwardable gets the job done(barely), but produces most unreadable code.

This is a nonintrusive (as is Forwardable) module that allows to delegate methods to instance variables,
objects returned by instance\_methods, other methods of the same receiver, the receiver itself, a chain of messages or
an arbitrary object. Paramters can be provided in the forwarding definition (parially or totally.

It also defines after and before filters.  and some more sophisticated use cases}

## Simple Delegation As In Forwardable

```ruby

forward <a_message>, to: <target>
forward <a_message>, to: <target>, as: <translation>
```

These two forms of the `forward` method, (and *only* these two forms) are directly translated to the
`def_delegator` method of `Forwardable`.

```ruby
def_delegator <target> <a_message>
def_delegator <translation> <a_message>
```

## Additional Features

* Parameters (partial or total application)
* Custom And Chained Targets
* AOP Filters


### Parameters

Assuming a class `ArrayWrapper` and that their instances wrap the array object via the instance variable
`@ary` the Smalltalk method `second` can be implemented as follows.

```ruby
require 'forwarder'
class ArrayWrapper
  extend Forwarder
  forward :second, to: :@ary, as: :[], with: 1
  ...
end
```

The `with` keyword paramter is thus used to provide the first slice of arguments that will be provided
to the forwarded invocation. This slice will be extended by the actual parameters of the invocation
of the proxy method (e.g. the instance method defined by the `forward` method itself).

If with is an array it is splatted into the invocation, as becomes obvious in this example.

```ruby

   forward :add_whitespace_to_punctuation,
           to:   :name,
           as:   :gsub!,
           with: [ /[,.]\b/, '\& ' ]
```

#### Passing One Array

If a real array shall be passed in as one parameter it can be wrapped into an array of one element,
or the `with_ary:` keyword parameter can be used.

Example:

```ruby
  forward :append_suffix, to: :@ary, as: :concat, with: [%w{ my suffix }]
  forward :append_suffix, to: :@ary, as: :concat, with_ary: %w{ my suffix }
```

#### Passing A Block

In case of the necessity to provide a block to the forwarded invocation, it can be specified as the
block parameter of the `forward` invocation itself.

The following example uses inject to compute a sum of elements

```ruby
  forward :sum, to: :elements, as: :inject do |s,e| s+e end
```

Please note however that common patterns like this one can benefit of the provided
helpers, in our case it is Integer.sum.

```ruby
require 'forwarder/helpers/integer/sum'
...
  forward :sum, to: :elements, as: :inject, &Integer.sum
# or
  forward :sum, to: :elements, as: :inject, with_block: Integer.sum
...
```

Accounting for different tastes a block can be provided as a block parameter or 
as a `lambda` to the `with_block:` keyword parameter. The later is taking preference
over the former, which no defined usage of the block in this case (at least for
the time being).

#### Selective Helpers

As we do not want to be intrusive the helpers
have to be requested explicitly.

This can be done in three levels of granularity:

* Per helper

`require 'forwarder/helpers/integer/sum'

* All helpers

`require 'forwarder/helpers'`,

* Per monkey patched class

`require 'forwarder/helpers/integer'`,

