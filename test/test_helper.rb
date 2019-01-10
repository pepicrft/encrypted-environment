# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../../lib", __FILE__))
require "encrypted/environment"

require "minitest/autorun"
require "byebug"
require "test_helpers"
require "mocha/minitest"
require "minitest/reporters"

require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)
