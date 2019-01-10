# frozen_string_literal: true

require "test_helper"
require 'tmpdir'
require 'fileutils'

module Encrypted
  class EnvironmentTest < Minitest::Test
    include TestHelpers::Fixture

    def test_load_from_ejson_when_secrets_path
      Environment.load_from_ejson(
        fixture_path("env.ejson"),
        secrets_path: fixture_path("keys")
      )
      ENV["TEST_VAR"] = "TEST_VALUE"
    end

    def test_load_from_ejson_when_private_key
      Environment.load_from_ejson(
        fixture_path("env.ejson"),
        private_key: "7f78c8e880b3fcea1b4828fe0edf32a0f1d012d83dd3a7bf9baa25dbc7128c12"
      )
      ENV["TEST_VAR"] = "TEST_VALUE"
    end

    def test_encrypt_ejson
      Dir.mktmpdir do |tmpdir|
        ejson_path = File.join(tmpdir, "env.ejson")
        FileUtils.cp(fixture_path("env.ejson"), ejson_path)

        json = JSON.parse(File.read(ejson_path))
        json["WAKA"] = "WAKA"
        File.write(ejson_path, json.to_json)
        Environment.encrypt_ejson(ejson_path, secrets_path: fixture_path("keys"))

        encrypted_value = JSON.parse(File.read(ejson_path))["WAKA"]
        assert encrypted_value
        refute_equal "WAKA", encrypted_value
      end
    end
  end
end
