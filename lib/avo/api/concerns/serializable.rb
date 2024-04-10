# frozen_string_literal: true

require "active_support/concern"

module Avo::Api
  module Concerns
    module Serializable
      extend ::ActiveSupport::Concern

      def as_json(options = {})
        get_fields.map do |field|
          [field.id, field.value]
        end.to_h
      end
    end
  end
end
