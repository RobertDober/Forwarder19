module Forwarder
  class Arguments
    attr_reader :message, :target

    def chain?
      @params[ :to_chain ]
    end

    def delegatable?
      messages.empty? && !chain?
    end

    def delegate_to_all?
      !messages.empty? && !chain?
    end

    def message
      messages.empty? && @message
    end

    def messages
      @messages ||= @message.is_a?( Array ) ? @message.dup : []
    end

    def translation alternative=nil, &blk
      @params[ :as ].tap do | tltion |
        break alternative unless tltion
        break tltion unless blk
        blk.( tltion ) 
      end
    end

    private
    def initialize *args, &blk
      @message = args.shift
      raise ArgumentError, "need one message and a hash of kwd params, plus an optional block" unless args.size == 1 && args.first.is_a?( Hash )
      @params = args.first
      set_target
    end

    def set_target
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
