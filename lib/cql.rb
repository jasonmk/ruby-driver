# encoding: utf-8

module Cql
  CqlError = Class.new(StandardError)
end

require 'cql/decoding'
require 'cql/frame'