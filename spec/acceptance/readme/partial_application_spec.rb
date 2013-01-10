#
# These specs assure that the README examples work as intented.
#

require 'lab419/core/integer'
require 'spec_helper'

describe Forwarder do
  describe "partial application" do
    let_forwarder_instance :wrapper, :str => "the,quick, brown.fox." do
      forward :add_to_punctuation,
              to: :@str,
              as: :gsub!,
              with: /[,.]\b/

      forward :add_ws_to_punctuation,
              to: :add_to_punctuation,
              with: '\1 '
    end

    it "adds strings where needed" do
      wrapper.add_to_punctuation( "***" )
      wrapper.str.should eq( "the***quick, brown***fox." )
    end

    it "can be a forwarding target" do
      wrapper.add_ws_to_punctuation
      wrapper.str.should eq( 'the, quick, brwon. fox.r' )
    end
  end # describe "passing more parameters"
end
