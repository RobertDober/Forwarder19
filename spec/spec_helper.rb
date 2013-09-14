lib_path = File.expand_path("../../lib", __FILE__ )
$:.unshift lib_path
require 'forwarder'

PROJECT_ROOT = File.expand_path "../..", __FILE__
Dir[File.join(PROJECT_ROOT,"spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.filter_run wip: true
  c.run_all_when_everything_filtered = true
end

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
