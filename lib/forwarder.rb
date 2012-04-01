require 'forwardable'

module Forwarder
  
  def forward *args, &blk
    params = Forwarder::Params.new( self )
    params.prepare_forward( *args, &blk )
    params.forward!
  end
end # module Forwarder
