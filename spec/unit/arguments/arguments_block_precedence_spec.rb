require 'spec_helper'
require 'forwarder/arguments'

describe Forwarder::Arguments do
  let( :message ){ :a_message }
  let( :target  ){ :a_target  }
  let( :before  ){ ->(){1}    }
  let( :after   ){ ->(){2}    }

  describe 'no block at all' do
    subject{ described_class.new message, to: target }
    it "does not have a lambda" do
      should_not be_lambda
    end
    it "does not have before" do
      subject.before.should be_nil
    end
    it "nor does it have after" do
      subject.after.should be_nil
    end
  end # describe 'no block at all'

  describe 'only a block' do
  subject{ described_class.new message, to: target do end }
    it "has a lambda" do
      should be_lambda
    end
    it "does not have before" do
      subject.before.should be_nil
    end
    it "nor does it have after" do
      subject.after.should be_nil
    end
  end # describe 'no block at all'

  describe 'only before' do
    subject{ described_class.new message, to: target, before: before }
    it "does not have a lambda" do
      should_not be_lambda
    end
    it "has a before" do
      subject.before.should eq( before )
    end
    it "nor does it have after" do
      subject.after.should be_nil
    end
  end # describe 'no block at all'

  describe 'after and block (after winning)' do
    subject{ described_class.new message, to: target, after: :use_block, &after }
    it "does not have a lambda" do
      should_not be_lambda
    end
    it "does not have before" do
      subject.before.should be_nil
    end
    it "has after" do
      subject.after.should eq( after )
    end
  end # describe 'no block at all'

  describe 'before and block (sharing)' do
    subject{ described_class.new message, to: target, before: before, &after }
    it "has a lambda" do
      should be_lambda
    end
    it "has a before" do
      subject.before.should eq( before )
    end
    it "nor does it have after" do
      subject.after.should be_nil
    end
  end # describe 'no block at all'

  describe 'after and block (sharing by means of with_block)' do
    subject{ described_class.new message, to: target, after: :use_block, with_block: before, &after }
    it "has a lambda" do
      subject.lambda.should eq( before )
    end
    it "does not have before" do
      subject.before.should be_nil
    end
    it "has after" do
      subject.after.should eq( after )
    end
  end # describe 'no block at all'

  describe 'use_block distinguishes target' do
    let :block do ->{3} end
    subject{ described_class.new message, to: target, after: :use_block, with_block: block, before: before, &after }
    it "has a lambda" do
      subject.lambda.should eq( block )
    end
    it "does not have before" do
      subject.before.should eq( before )
    end
    it "has after" do
      subject.after.should eq( after )
    end
  end # describe 'no block at all'
  
end # describe Forwarder::Arguments
