require 'forwardable'
require 'forwarder/params'

module Forwarder
  
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

module FForwarder
  
  def forward *args, &blk
    params = FForwarder::Params.new self
    params.prepare_forward( *args, &blk )
    params.forward!
  end

  def forward_all *args, &blk
    params = FForwarder::Params.new self
    opts   = args.pop
    params.prepare_forward( args, opts, &blk )
    params.forward!
  end
end # module FForwarder
