# frozen_string_literal: true

module TestHelpers
  module Fixture
    def fixture_path(path)
      File.expand_path(File.join(__dir__, "../fixtures", path))
    end
  end
end
