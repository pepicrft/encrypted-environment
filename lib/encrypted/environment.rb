# frozen_string_literal: true

require "encrypted/environment/version"
require 'json'
require 'tmpdir'
require 'fileutils'

module Encrypted
  module Environment
    EnvironmentError = Class.new(StandardError)
    MissingEjson = Class.new(EnvironmentError)

    def self.load_from_ejson(ejson_path, secrets_path: nil, private_key: nil)
      decrypt_environment(
        ejson_path: ejson_path,
        secrets_path: secrets_path,
        private_key: private_key
      ).each do |key, value|
        ENV[key] = value if key != "_public_key"
      end
    end

    def self.encrypt_ejson(ejson_path, secrets_path: nil, private_key: nil)
      with_secrets(ejson_path: ejson_path, secrets_path: secrets_path, private_key: private_key) do |path|
        %x(EJSON_KEYDIR=#{path} bundle exec ejson encrypt #{ejson_path})
      end
    end

    class << self
      private

      def decrypt_environment(ejson_path:, secrets_path: nil, private_key: nil)
        with_secrets(ejson_path: ejson_path, secrets_path: secrets_path, private_key: private_key) do |path|
          output = %x(EJSON_KEYDIR=#{path} bundle exec ejson decrypt #{ejson_path})
          JSON.parse(output)
        end
      end

      def with_secrets(ejson_path:, secrets_path: nil, private_key: nil)
        raise MissingEjson unless File.exist?(ejson_path)

        content = File.read(ejson_path)
        ejson = JSON.parse(content)
        public_key = ejson["_public_key"]
        should_delete = false

        if !secrets_path.nil? && File.exist?(secrets_path)
          # Do nothing
        elsif !private_key.nil?
          secrets_path = Dir.mktmpdir
          should_delete = true
          File.write(File.join(secrets_path, public_key), private_key)
        end

        yield(secrets_path)
      ensure
        FileUtils.remove_dir(secrets_path, true) if should_delete
      end
    end
  end
end
