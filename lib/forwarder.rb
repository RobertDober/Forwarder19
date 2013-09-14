require 'forwardable'
require 'forwarder/params'

module Forwarder
  
  # How forward works:
  # The parameters are analyzed by the Params object by means of the `prepare_forward`
  # method. The `prepare_forward` method makes havy use of the Argument object which
  # implements a query API for what the given arguments allow the forwarder to do.
  # And eventually the `forward!` method realises the delegation.
  def forward *args, &blk
    params = Forwarder::Params.new self
    params.prepare_forward( *args, &blk )
    params.forward!
  end

  def forward_all *args, &blk
    params = Forwarder::Params.new self
    opts   = args.pop
    params.prepare_forward( args, opts, &blk )
    params.forward!
  end
end # module Forwarder
