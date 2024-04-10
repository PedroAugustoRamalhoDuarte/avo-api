# frozen_string_literal: true

require "spec_helper"

RSpec.describe "ResourceController", type: :request do
  describe "GET transactions/id" do
    it "returns http success" do
      t = Transaction.create!(amount: 20, side: "credit")
      get "/avo/api/transactions/#{t.id}"
      expect(response).to have_http_status(:success)
    end

    it "returns the right fields" do
      t = Transaction.create!(amount: 20, side: "credit", id: 1)
      get "/avo/api/transactions/#{t.id}"
      expect(JSON.parse(response.body)).to eq({
                                                "id" => 1,
                                                "side" => "credit",
                                                "amount" => 20
                                              })
    end
  end
end
