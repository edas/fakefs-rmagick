require "bundler/setup"
require "rmagick"
require "fakefs/safe"
require "fakefs_rmagick/safe"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
