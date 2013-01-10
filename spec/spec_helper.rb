lib_path = File.expand_path("../../lib", __FILE__ )
$:.unshift lib_path
require 'forwarder'

def let_forwarder_instance let_name, values={}, &blk
  let! let_name do
    Class.new do
      values.keys.each do | k |
        attr_accessor k
      end
      extend Forwarder
      define_method :initialize do
        values.each do | name, value |
          instance_variable_set "@#{name}", value
        end
      end

    end.tap do | klass |
      klass.module_eval( &blk ) if blk
    end.new
  end
end
