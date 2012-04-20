require 'forwarder/evaller'
module Forwarder
  class Compiler
    attr_reader :arguments

    
    def compile
      # Cannot compile because of intrinsic uncompilable traits of arguments
      # TODO: implement compilable inside arguments
#      return unless !arguments.lambda? && !arguments.aop? && !arguments.custom_target?
      return if arguments.must_not_compile?
      # Cannot compile because arguments cannot be compiled
      @compiled_args = Evaller.serialize arguments.args
      return unless @compiled_args
      # Can compile :)))
      return compile_to_all if arguments.message.is_a? Array
      compile_one
    end

    private

    def compile_to_all
      arguments.message.map{ |msg|
        "def #{msg} *args, &blk; #{arguments.target}.#{msg}( *args, &blk ) end"
      }.join("\n")
    end

    def compile_one
      tltion = arguments.translation arguments.message
      "def #{arguments.message} *args, &blk; " +
        "#{self.class.compile_target arguments.target}.#{tltion}( " +
        @compiled_args +
        "*args, &blk ) end"
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
