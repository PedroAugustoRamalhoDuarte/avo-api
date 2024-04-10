module Avo::Api
  class ResourcesController < ActionController::Base
    include Avo::InitializesAvo

    before_action :init_app
    before_action :set_resource_name
    before_action :set_resource
    before_action :set_record, only: [:show]

    def show
      @resource.hydrate(record: @record, view: :show, current_user: _current_user, params: params).detect_fields
      render json: @resource
    end

    private

    # TODO: Copied method
    def set_record
      id = if @resource.model_class.primary_key.is_a?(Array) && params.respond_to?(:extract_value)
             params.extract_value(:id)
           else
             params[:id]
           end

      # TODO: Changes from original method  undefined method `avo' for an instance of #<Class:0x00007fc0eb1305c0>
      @record = @resource.model_class.find(id)
      @resource.hydrate(record: @record)
    end

    # TODO: Copied method
    def model_scope
      # abort @resource.inspect
      @resource.class.find_scope
    end

    # TODO: Copied method
    def resource
      resource = Avo.resource_manager.get_resource @resource_name.to_s.camelize.singularize

      return resource if resource.present?

      Avo.resource_manager.get_resource_by_controller_name @resource_name
    end

    # TODO: Copied method
    def set_resource_name
      @resource_name = resource_name
    end

    # TODO: Copied method
    def set_resource
      raise ActionController::RoutingError.new "No route matches" if resource.nil?

      @resource = resource.new(view: params[:view].presence || action_name.to_s, user: _current_user, params: params)

      set_authorization
    end

    # TODO: Copied method
    def set_authorization
      # We need to set @resource_name for the #resource method to work properly
      set_resource_name
      @authorization = if @resource
                         @resource.authorization(user: _current_user)
                       else
                         Services::AuthorizationService.new _current_user
                       end
    end

    # TODO: Copied method
    def resource_name
      return params[:resource_name] if params[:resource_name].present?

      return controller_name if controller_name.present?

      begin
        request.path
               .match(/\/?#{Avo.root_path.delete('/')}\/resources\/([a-z1-9\-_]*)\/?/mi)
               .captures
               .first
      rescue
      end
    end
  end
end
