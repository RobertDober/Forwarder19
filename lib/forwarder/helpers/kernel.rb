module Kernel
  def sendmsg *args, &blk
    -> receiver do 
      receiver.send( *args, &blk )
    end
  end

  def applyto *args
    msg_or_lambda = args.shift
    case msg_or_lambda
    when String, Symbol
      -> *a do
        send( msg_or_lambda, *(args + a) )
      end
    when Proc
      -> *a do
        msg_or_lambda.( *(args + a) )
      end
    else
      raise ArgumentError, "need a message (str or sym) or a lambda to be applied to"
    end
  end
end # module Kernel
