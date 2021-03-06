# encoding: ascii-8bit

# Copyright 2013-2014 DataStax, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#++

require 'spec_helper'


module Cassandra
  module Protocol
    describe SchemaChangeEventResponse do
      describe '.decode' do
        let :response do
          buffer = CqlByteBuffer.new("\x00\aDROPPED\x00\ncql_rb_609\x00\x05users")
          described_class.decode(1, buffer, buffer.length)
        end

        it 'decodes the change' do
          response.change.should == 'DROPPED'
        end

        it 'decodes the keyspace' do
          response.keyspace.should == 'cql_rb_609'
        end

        it 'decodes the table' do
          response.table.should == 'users'
        end
      end

      describe '#to_s' do
        it 'returns a string with the change, keyspace and table' do
          response = described_class.new('DROPPED', 'ks', 'tbl')
          response.to_s.should == 'EVENT SCHEMA_CHANGE DROPPED "ks" "tbl"'
        end
      end

      describe '#eql?' do
        it 'is equal to an identical response' do
          r1 = described_class.new('DELETED', 'keyspace_name', 'table_name')
          r2 = described_class.new('DELETED', 'keyspace_name', 'table_name')
          r1.should eql(r2)
        end

        it 'is not equal when the change is different' do
          r1 = described_class.new('DELETED', 'keyspace_name', 'table_name')
          r2 = described_class.new('CREATED', 'keyspace_name', 'table_name')
          r1.should_not eql(r2)
        end

        it 'is not equal when the keyspace is different' do
          r1 = described_class.new('DELETED', 'keyspace_name', 'table_name')
          r2 = described_class.new('DELETED', 'eman_ecapsyek', 'table_name')
          r1.should_not eql(r2)
        end

        it 'is not equal when the table is different' do
          r1 = described_class.new('DELETED', 'keyspace_name', 'table_name')
          r2 = described_class.new('DELETED', 'keyspace_name', 'eman_elbat')
          r1.should_not eql(r2)
        end

        it 'is aliased as ==' do
          r1 = described_class.new('DELETED', 'keyspace_name', 'table_name')
          r2 = described_class.new('DELETED', 'keyspace_name', 'table_name')
          r1.should == r2
        end
      end

      describe '#hash' do
        it 'is the same for an identical response' do
          r1 = described_class.new('DELETED', 'keyspace_name', 'table_name')
          r2 = described_class.new('DELETED', 'keyspace_name', 'table_name')
          r1.hash.should == r2.hash
        end

        it 'is not the same when the change is different' do
          r1 = described_class.new('DELETED', 'keyspace_name', 'table_name')
          r2 = described_class.new('CREATED', 'keyspace_name', 'table_name')
          r1.hash.should_not == r2.hash
        end

        it 'is not the same when the keyspace is different' do
          r1 = described_class.new('DELETED', 'keyspace_name', 'table_name')
          r2 = described_class.new('DELETED', 'eman_ecapsyek', 'table_name')
          r1.hash.should_not == r2.hash
        end

        it 'is not the same when the table is different' do
          r1 = described_class.new('DELETED', 'keyspace_name', 'table_name')
          r2 = described_class.new('DELETED', 'keyspace_name', 'eman_elbat')
          r1.hash.should_not == r2.hash
        end
      end
    end
  end
end
