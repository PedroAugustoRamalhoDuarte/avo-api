# frozen_string_literal: true

require "avo/api"

ENV["RAILS_ENV"] = "test"

require_relative "../spec/dummy/config/environment"

ENV["RAILS_ROOT"] ||= "#{File.dirname(__FILE__)}../../../spec/dummy"

require "rspec/rails"
require "database_cleaner"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.after(:suite) do
    FileUtils.rm_rf(File.expand_path("../test.sqlite3", __FILE__))
  end
end
