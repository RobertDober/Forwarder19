require 'benchmark'

require 'forwardable'

class A # for ary
  def initialize
    @ary = %w{Is this fast ?}
  end
end

class F < A # for Forwardable
  extend Forwardable
  def_delegator :@ary, :length
end # class F

class E < A # for evalled
  module_eval "def length; @ary.length end"
end # class E

f = F.new
e = E.new
abort "error" unless f.length == 4
abort "error" unless e.length == 4

N = 10_000

Benchmark.bmbm do |x|
  x.report "forwardable" do
    (N*ARGV.fetch(0,1).to_i).times{ f.length }
  end
  x.report "evalled" do
    (N*ARGV.fetch(0,1).to_i).times{ e.length }
  end
    
end
