require 'spec_helper'
require 'forwarder/params'

describe Forwarder::Params do
  describe "when it can use Forwardable" do
    let :forwardee do double "forwardee" end 
    let :target do :@ivar_name end
    let :message do :a_message end

    subject do
      described_class.new( forwardee )
    end

    it "forwards to a target with a param" do
      forwardee
        .should_receive( :module_eval )
        .with( "def #{message} *args, &blk; #{target}.[](42, *args, &blk ) end", anything, anything )
      subject.prepare_forward( message, to: target, as: :[], with: 42 )
      subject.forward!
    end
  end

end # describe Forwarder::Params
