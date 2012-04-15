require 'spec_helper'
require 'forwarder/params'

describe Forwarder::Params do
  describe "when it can use Forwardable" do
    let :forwardee do double "forwardee" end 
    let :target do :@ivar_name end
    let :message do :a_message end
    let :translation do :another_message end

    subject do
      described_class.new( forwardee )
    end

    it "forwards to a target" do
      forwardee
        .should_receive( :module_eval )
        .with( "def #{message} *args, &blk; #{target}.#{message}( *args, &blk ) end", anything, anything )
      subject.prepare_forward( message, to: target )
      subject.forward!
    end
    it "forward to a target with translation" do
      forwardee
        .should_receive( :module_eval )
        .with( "def #{message} *args, &blk; #{target}.#{translation}( *args, &blk ) end", anything, anything )
      subject.prepare_forward( message, to: target, as: translation )
      subject.forward!
    end
  end

end # describe Forwarder::Params
