require 'spec_helper'
require 'forwarder/arguments'

describe Forwarder::Arguments do
  describe ArgumentError do
    it 'is raised for too few args' do
      ->{ described_class.new :hello }.should raise_error( ArgumentError )
    end
    it 'is raised for too many args' do
      ->{ described_class.new :hello, {to: :friend}, 42 }.should raise_error( ArgumentError )
    end
  end # describe ArgumentError
end # describe Forwarder::Arguments do
