# frozen_string_literal: true

require "spec_helper"
require "avo/api"
#require "avo/api/concerns/serializable"

class User
  include ActiveModel::Model
  attr_accessor :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

end

class Resource < Avo::BaseResource
  include Avo::Api::Concerns::Serializable

  def fields
    field :id, as: :id
    field :name, as: :text
    field :formatted_name, as: :text do
      "Formatted #{record.name}"
    end
  end
end

RSpec.describe "Resource#to_json" do
  it "returns the right" do
    resource = Resource.new.hydrate(record: User.new(id: 1, name: "Name"), view: :show).detect_fields
    expect(JSON.parse(resource.to_json)).to eq({
                                                 "Id" => 1,
                                                 "Name" => "Name",
                                                 "Formatted name" => "Formatted Name"
                                               })
  end

end
