module Forwarder
  # I am the workerbee defining the methods and stuff
  class Meta

    attr_reader :arguments, :forwardee


    def forward
      a = arguments
      sr = symbolic_receiver
      forwardee.module_eval do
       
        define_method a.message do |*args, &blk|
          sr
            .( self, a.target )
            .send( a.translation( a.message ), *a.complete_args(*args), &a.lambda( blk ) ) 
        end
      end
    end

    def forward_chain
      a = arguments
      sr = symbolic_receiver
      forwardee.module_eval do
        define_method a.message do |*args, &blk|
          a
            .target
            .inject( self ){ |r, sym| sr.( r, sym ) }
            .send( a.translation( a.message ), *a.complete_args(*args), &a.lambda( blk ) ) 
        end
      end
    end

    def forward_object
      a = arguments
      forwardee.module_eval do
        define_method a.message do |*args, &blk|
          a.object_target( self )
            .send( a.translation( a.message ), *a.complete_args(*args), &a.lambda(blk) ) 
        end
      end
      
    end

    private
    def initialize forwardee, arguments
      @forwardee = forwardee
      @arguments = arguments
    end

    def symbolic_receiver
      @__symbolic_receiver__ = ->(rec, sym) do
        case "#{sym}"
        when /\A@/
          rec.instance_variable_get sym
        else
          rec.send sym
        end 
      end
    end

  end # class Meta
end # module Forwarder
