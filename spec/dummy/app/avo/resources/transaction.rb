# frozen_string_literal: true

class Avo::Resources::Transaction < Avo::BaseResource
  include Avo::Api::Concerns::Serializable

  self.title = :id
  self.includes = []

  def fields
    field :id, as: :id
    field :side, as: :text
    field :amount, as: :number
    field :created_at, as: :date, hide_on: [:show]
    field :updated_at, as: :date, hide_on: [:show]
  end
end
