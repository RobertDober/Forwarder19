require 'forwarder/arguments'
module Forwarder
  class Params
    attr_reader :forwardee, :arguments
    def prepare_forward *args, &blk
      @arguments = Arguments.new( *args, &blk ) 
    end
    private
    def initialize forwardee
      @forwardee = forwardee
    end
  end # class Params
end # module Forwarder
