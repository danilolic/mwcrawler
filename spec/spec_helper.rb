# frozen_string_literal: true

require 'bundler/setup'
require 'mwcrawler'
require 'webmock/rspec'
require 'vcr'
require 'coveralls'

Coveralls.wear!

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
