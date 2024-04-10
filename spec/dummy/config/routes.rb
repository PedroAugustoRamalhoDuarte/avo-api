# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :avo do
    namespace :api do
      resources :transactions
    end
  end
end
