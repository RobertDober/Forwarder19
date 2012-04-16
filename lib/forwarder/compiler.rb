module Forwarder
  class Compiler
    attr_reader :arguments

    def compile
      return unless !arguments.lambda? && !arguments.aop? && !arguments.args? 
      tltion = arguments.translation arguments.message
      "def #{arguments.message} *args, &blk; #{arguments.target}.#{tltion}( *args, &blk ) end"
    end
    private
    def initialize args
      @arguments = args 
    end
    
  end # class Compiler
end # module Forwarder
