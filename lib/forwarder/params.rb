require 'forwarder/arguments'
require 'forwarder/meta'
module Forwarder
  class Params
    attr_reader :forwardee, :arguments
    def forward!
      return if delegate
      return if delegate_all
      return if delegate_chain  
      return if delegate_object
      general_delegate
    end

    def prepare_forward *args, &blk
      @arguments = Arguments.new( *args, &blk ) 
    end
    
    private

    def delegate
      return unless arguments.delegatable? 
      delegate_to_forwardee
      true
    end

    def delegate_all
      return unless arguments.all?
      delegate_all_to_forwardee
      true
    end

    def delegate_all_to_forwardee
      arguments.message.each do | msg |
        forwardee.module_eval(
          "def #{msg} *args, &blk; #{arguments.target}.#{msg}( *args, &blk ) end",
          __FILE__,
          __LINE__
        )
      end
    end


    def delegate_chain
      return unless arguments.chain?
      delegate_to_chain
      true
    end

    def delegate_to_chain
      tltion = arguments.translation arguments.message
      forwardee.module_eval(
        "def #{arguments.message} *args, &blk; #{arguments.target.join(".")}.#{tltion}( *args, &blk ) end",
          __FILE__,
          __LINE__
      )
    end

    def delegate_object
      return unless arguments.custom_target?
      Meta.new( forwardee, arguments ).forward_object
      true
    end
      
    def delegate_to_forwardee
      tltion = arguments.translation arguments.message
      forwardee.module_eval(
        "def #{arguments.message} *args, &blk; #{arguments.target}.#{tltion}( #{arguments.serialized_params}*args, &blk ) end",
        __FILE__,
        __LINE__
      )
    end

    def initialize forwardee
      @forwardee = forwardee
    end

    def general_delegate
      Meta.new( forwardee, arguments ).forward
    end
  end # class Params
end # module Forwarder
