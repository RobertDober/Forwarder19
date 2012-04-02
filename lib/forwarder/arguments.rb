module Forwarder
  class Arguments
    attr_reader :message, :target

    def delegatable?; true end

    def translation &blk
      @params[ :as ].tap do | tltion |
        break unless tltion
        break tltion unless blk
        blk.( tltion ) 
      end
    end

    private
    def initialize *args, &blk
      @message = args.shift
      raise ArgumentError, "need one message and a hash of kwd params, plus an optional block" unless args.size == 1 && args.first.is_a?( Hash )
      @params = args.first
      get_target
    end

    def get_target
      [:to, :to_chain, :to_object].each do | tgt_kwd |
        tgt = @params[ tgt_kwd ]
        next unless tgt

        raise ArgumentError, "more than one target specified." if @target
        @target = tgt 
      end
      raise ArgumentError, "no target specified." unless @target
    end
  end # class Arguments
end # module Forwarder
