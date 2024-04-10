require "ostruct"

module Avo::Api
  class ResourcesController < Avo::BaseController
    def index
      @resource.hydrate(record: @record, view: :index, user: _current_user, params: params).detect_fields

      render json: @resource
    end
  end
end
