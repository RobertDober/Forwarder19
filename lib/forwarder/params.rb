require 'forwarder/arguments'
module Forwarder
  class Params
    attr_reader :forwardee, :arguments
    def forward!
      return if delegate
      return if delegate_all
    end
    def prepare_forward *args, &blk
      @arguments = Arguments.new( *args, &blk ) 
    end
    
    private

    def delegate
      arguments.delegatable? and delegate_to_forwardee
    end

    def delegate_all
      arguments.delegate_to_all? and delegate_all_to_forwardee
    end

    def delegate_all_to_forwardee
      forwardee.extend Forwardable
      forwardee.def_delegators( arguments.target, *arguments.messages )
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
  end # class Params
end # module Forwarder
