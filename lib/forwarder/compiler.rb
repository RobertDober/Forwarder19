module Forwarder
  class Compiler
    attr_reader :arguments

    
    def compile
      return unless !arguments.lambda? && !arguments.aop? && !arguments.args? && !arguments.custom_target?
      return compile_to_all if arguments.message.is_a? Array
      tltion = arguments.translation arguments.message
      "def #{arguments.message} *args, &blk; #{self.class.compile_target arguments.target}.#{tltion}( *args, &blk ) end"
    end
    private

    def compile_to_all
      arguments.message.map{ |msg|
        "def #{msg} *args, &blk; #{arguments.target}.#{msg}( *args, &blk ) end"
      }.join("\n")
    end

    def initialize args
      @arguments = args 
    end
    
    class << self
      def compile_target target
        [ target ].flatten.join( "." )
      end
    end
  end # class Compiler
end # module Forwarder
