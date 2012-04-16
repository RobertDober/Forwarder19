module Forwarder
  module Evaller extend self
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
  end # module Evaller
end # module Forwarder
