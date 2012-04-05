lib_path = File.expand_path("../../lib", __FILE__ )
$:.unshift lib_path
require 'forwarder'

def let_forwarder_instance let_name, values={}
  let let_name do
    Class.new do
      extend Forwarder
      define_method :initialize do
        values.each do | name, value |
          instance_variable_set "@#{name}", value
        end
      end
    end
  end
end
