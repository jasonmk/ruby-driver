# encoding: utf-8

require 'spec_helper'

module Cql
  module Retry
    module Policies
      describe(Fallthrough) do
        let(:policy) { Fallthrough.new }

        describe('#read_timeout') do
          let(:statement)          { VOID_STATEMENT }
          let(:consistency)        { :one }
          let(:required_responses) { 1 }
          let(:received_responses) { 0 }
          let(:data_retrieved)     { false }
          let(:retries)            { 0 }

          let(:decision) do
            policy.read_timeout(statement, consistency, required_responses,
                                received_responses, data_retrieved, retries)
          end

          it 'reraises' do
            expect(decision).to be_a(Decisions::Reraise)
          end
        end

        describe('#write_timeout') do
          let(:statement)     { VOID_STATEMENT }
          let(:consistency)   { :one }
          let(:write_type)    { 'SIMPLE' }
          let(:acks_required) { 1 }
          let(:acks_received) { 0 }
          let(:retries)       { 0 }

          let(:decision) do
            policy.write_timeout(statement, consistency, write_type,
                                 acks_required, acks_received, retries)
          end

          it 'reraises' do
            expect(decision).to be_a(Decisions::Reraise)
          end
        end

        describe('#unavailable') do
          let(:statement)         { VOID_STATEMENT }
          let(:consistency)       { :one }
          let(:replicas_required) { 1 }
          let(:replicas_alive)    { 0 }
          let(:data_retrieved)    { false }
          let(:retries)           { 0 }

          let(:decision) do
            policy.unavailable(statement, consistency, replicas_required,
                               replicas_alive, retries)
          end

          it 'reraises' do
            expect(decision).to be_a(Decisions::Reraise)
          end
        end
      end
    end
  end
end
