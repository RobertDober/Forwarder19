module Forwarder
  # I am the workerbee defining the methods and stuff
  class Meta

    attr_reader :arguments, :forwardee

    def forward
      a = arguments
      forwardee.module_eval do
        define_method a.message do |*args, &blk|
          a.target.inject( self ){ |r, m| r.send m } 
        end
      end
    end
    private
    def initialize forwardee, arguments
      @forwardee = forwardee
      @arguments = arguments
    end
    
  end # class Meta
end # module Forwarder
