#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'
require 'ostruct'

describe Forwarder do

  describe 'forward to hash chain without translation' do
    let_forwarder_instance :wrapper, proxy: OpenStruct.new(h: {a:42, b:43}) do
      forward :a, to_hash: [:@proxy, :h]
    end
    it 'works too :)' do
      wrapper.a.should eq( 42 )
    end

  end # describe 'forward to hash chain'

  describe 'forward to hash chain with translation' do
    let_forwarder_instance :wrapper, proxy: OpenStruct.new(h: {a:42, b:43}) do
      forward :a, to_hash: [:@proxy, :h], as: :b
    end
    it 'works uses key b' do
      wrapper.a.should eq( 43 )
    end

  end # describe 'forward to hash chain'

  describe 'forward all to hash chain' do
    let_forwarder_instance :wrapper, proxy: OpenStruct.new(h: {a:42, b:43}) do
      forward_all :a, :b, to_hash: [:@proxy, :h]
    end
    it 'forwards a' do
      wrapper.a.should eq( 42 )
    end
    it 'and it forwards b' do
      wrapper.b.should eq( 43 )
    end

  end # describe 'forward to hash chain'
end # describe Forwarder do
