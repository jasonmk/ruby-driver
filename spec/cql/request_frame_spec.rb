# encoding: ascii-8bit

require 'spec_helper'


module Cql
  describe RequestFrame do
    let :frame do
      described_class.new
    end

    it 'encodes an OPTIONS request' do
      bytes = RequestFrame.new(OptionsRequest.new).write('')
      bytes.should == "\x01\x00\x00\x05\x00\x00\x00\x00"
    end

    context 'with STARTUP requests' do
      it 'encodes the request' do
        bytes = RequestFrame.new(StartupRequest.new('3.0.0', 'snappy')).write('')
        bytes.should == "\x01\x00\x00\x01\x00\x00\x00\x2b\x00\x02\x00\x0bCQL_VERSION\x00\x053.0.0\x00\x0bCOMPRESSION\x00\x06snappy"
      end

      it 'defaults to CQL 3.0.0 and no compression' do
        bytes = RequestFrame.new(StartupRequest.new()).write('')
        bytes.should == "\x01\x00\x00\x01\x00\x00\x00\x16\x00\x01\x00\x0bCQL_VERSION\x00\x053.0.0"
      end
    end

    context 'with REGISTER requests' do
      it 'encodes the request' do
        bytes = RequestFrame.new(RegisterRequest.new('TOPOLOGY_CHANGE', 'STATUS_CHANGE')).write('')
        bytes.should == "\x01\x00\x00\x0b\x00\x00\x00\x22\x00\x02\x00\x0fTOPOLOGY_CHANGE\x00\x0dSTATUS_CHANGE"
      end
    end
  end
end