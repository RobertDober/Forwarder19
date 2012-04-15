require 'spec_helper'
require 'forwarder/params'

describe Forwarder::Params do
  describe "when it can use Forwardable" do
    let :forwardee do double "forwardee" end 
    let :target do :@ivar_name end
    let :message1 do :a_message end
    let :message2 do :another_message end

    subject do
      described_class.new( forwardee )
    end

    it "forwards to a target" do
      forwardee
        .should_receive( :module_eval )
        .with( "def #{message1} *args, &blk; #{target}.#{message1}( *args, &blk ) end", anything, anything ).ordered
      forwardee
        .should_receive( :module_eval )
        .with( "def #{message2} *args, &blk; #{target}.#{message2}( *args, &blk ) end", anything, anything ).ordered
      subject.prepare_forward( [message1, message2], to: target )
      subject.forward!
    end
  end

end # describe Forwarder::Params
