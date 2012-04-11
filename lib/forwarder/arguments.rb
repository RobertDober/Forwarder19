module Forwarder
  class Arguments
    attr_reader :args, :message, :target

    def all?
      !args? && !lambda? && @__all__
    end

    def aop?
      @__aop__ ||= !@params.values_at(:after, :before).compact.empty?
    end

    def args?
      !!args
    end

    def chain?
      @params[ :to_chain ]
    end

    def custom_target?
      @params[:to_object]
    end

    def delegatable?
      !aop? && !custom_target? && !all? && !chain? && !args && !lambda?
    end

    def complete_args *args
      (self.args || []) + args
    end

    def lambda default=nil
      @lambda || default
    end

    def lambda?
      @lambda
    end

    # This is always nil unless we are a custom_target, in which case
    # default is returned if target is :self, else target is returned
    def object_target default
      return unless custom_target?
      target == :self ? default : target
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
      set_message
      set_target
      set_args blk
    end

    def set_args blk
      set_lambda blk
      hw = @params.has_key? :with
      ha = @params.has_key? :with_ary
      raise ArgumentError, "cannot use :with and :with_ary parameter" if hw && ha
      set_args_normal if hw
      set_args_ary if ha
    end

    def set_args_ary
      @args = [ @params[:with_ary] ]
      raise ArgumentError, ":with_ary needs an array parameter" unless Array === @args.first
    end

    def set_args_normal
      case arg = @params[:with]
      when Array
        @args = arg.dup
      else
        @args = [ arg ]
      end
    end

    def set_message
      case @message
      when Array
        @__all__ = true
      end
    end

    def set_lambda blk
      raise ArgumentError, "cannot use :with_block and a block" if
        @params[:with_block] && blk
      @lambda = @params.fetch :with_block, blk
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
