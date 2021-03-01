# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  root to: "home#index"
  get "/products", to: "products#index"
  mount ShopifyApp::Engine, at: "/"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post "new_order" => "ship_station_integration#handle_new_order"
      post "new_shipped_order" => "ship_station_integration#handle_new_shipped_order"
      resources :orders, only: [:show, :index]
      post "/orders/generate" => "orders#generate_pdfs"
      post "/orders/archive" => "orders#archive"
    end
  end
end
