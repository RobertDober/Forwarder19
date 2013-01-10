#
# These specs assure that the README examples work as intented.
#

require 'lab419/core/integer'
require 'spec_helper'

describe Forwarder do
  describe "partial application" do
    let( :str ){ "the,quick, brown.fox." }
    let :klass do
      Struct.new :str do
        extend Forwarder
        forward :add_to_punctuation,
          to: :str,
          as: :gsub!,
          with: /([,.])\b/

        forward :add_ws_to_punctuation,
          to_object: :self,
          as: :add_to_punctuation,
          with: '\1 '

        forward :add_ws_to_punctuation_block,
          to_object: :self,
          as: :add_to_punctuation,
          with_block: ->(*gps){ "#{gps.first} " }
      end
    end
    before do
      @wrapper = klass.new str.dup
    end

    it "adds strings where needed" do
      @wrapper.add_to_punctuation( "***" )
      @wrapper.str.should eq( "the***quick, brown***fox." )
    end

    it "can be a forwarding target" do
      @wrapper.add_ws_to_punctuation
      @wrapper.str.should eq( 'the, quick, brown. fox.' )
    end
    it "can be a forwarding target (adding a block)" do
      @wrapper.add_ws_to_punctuation_block
      @wrapper.str.should eq( 'the, quick, brown. fox.' )
    end
  end # describe "passing more parameters"
end
