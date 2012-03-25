module Kernel
  def sendmsg *args, &blk
    lambda{ |receiver| receiver.send( *args, &blk ) }
  end
end # module Kernel
