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
      forwardee.extend Forwardable
      forwardee.def_delegators( arguments.target, *arguments.message )
    end


    def delegate_chain
      return unless arguments.chain?
      delegate_to_chain
      true
    end

    def delegate_to_chain
      Meta.new( forwardee, arguments ).forward_chain
    end

    def delegate_object
      return unless arguments.custom_target?
      Meta.new( forwardee, arguments ).forward_object
      true
    end
      
    def delegate_to_forwardee
      forwardee.extend Forwardable
      arguments.translation do | tltion |
        forwardee.def_delegator arguments.target, tltion, arguments.message
      end or
        forwardee.def_delegator arguments.target, arguments.message
    end

    def initialize forwardee
      @forwardee = forwardee
    end

    def general_delegate
      Meta.new( forwardee, arguments ).forward
    end
  end # class Params
end # module Forwarder
module FForwarder
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
      forwardee.extend Forwardable
      forwardee.def_delegators( arguments.target, *arguments.message )
    end


    def delegate_chain
      return unless arguments.chain?
      delegate_to_chain
      true
    end

    def delegate_to_chain
      Meta.new( forwardee, arguments ).forward_chain
    end

    def delegate_object
      return unless arguments.custom_target?
      Meta.new( forwardee, arguments ).forward_object
      true
    end
      
    def delegate_to_forwardee
      forwardee.extend Forwardable
      arguments.translation do | tltion |
        forwardee.def_delegator arguments.target, tltion, arguments.message
      end or
        forwardee.def_delegator arguments.target, arguments.message
    end

    def initialize forwardee
      @forwardee = forwardee
    end

    def general_delegate
      Meta.new( forwardee, arguments ).forward
    end
  end # class Params
end # module Forwarder
