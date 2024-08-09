# frozen_string_literal: true

Rails.application.routes.draw do
  concern :api do
    resources :ebooks, only: %i[index show create]
  end

  namespace :v1 do
    concerns :api
  end

  namespace :v2 do
    concerns :api
  end

  namespace :v3 do
    concerns :api
  end
end
