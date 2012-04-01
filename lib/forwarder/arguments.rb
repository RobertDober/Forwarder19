module Forwarder
  class Arguments
    attr_reader :message, :target
    private
    def initialize *args, &blk
      @message = args.shift
      raise ArgumentError, "need one message and a hash of kwd params, plus an optional block" unless args.size == 1 && args.first.is_a?( Hash )
      params = args.first
      @target = get_target_from params
      
    end
  end # class Arguments
end # module Forwarder
