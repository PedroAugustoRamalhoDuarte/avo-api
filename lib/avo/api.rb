# frozen_string_literal: true

require "rails"
require_relative "api/version"
require_relative "api/concerns/serializable"

module Avo
  module Api
    class Error < StandardError; end
    # Your code goes here...
  end
end

require_relative "api/rails" if defined?(Rails)
