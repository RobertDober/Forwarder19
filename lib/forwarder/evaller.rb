module Forwarder
  module Evaller extend self

    NotSerializable = Class.new RuntimeError

    def evaluable? an_object, cache={}
      oi = an_object.object_id
      return cache[oi] if cache.has_key? oi
      case an_object
      when String, Symbol, Fixnum
        cache[oi] = true
      when Array
        cache[oi] =
          an_object.all?{ |e| evaluable? e }
      when Hash
        cache[oi] = false # recurse into Hash in later versions
      else
        cache[oi] = false
      end
    end

    def serialize args
      return "" if args.nil? || args.empty?
      _serialize( args ).join(", ") + ", "
    rescue NotSerializable
      nil
    end

    private
    def _serialize args
      args.map{ | arg |
        _serialize_one arg
      }
    end

    def _serialize_one arg
      case arg
      when String, Symbol, Fixnum, NilClass, FalseClass, TrueClass
        arg.inspect
      when Array
        ["[ ", _serialize( arg ).join(", "), " ]"].join
      when Hash
        raise NotSerializable # implement later
      else
        raise NotSerializable
      end
    end
  end # module Evaller
end # module Forwarder
