Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :contacts, only: [:create, :update, :destroy]
      get "/hello", to: "contacts#hello"
      post "/token", to: "contacts#find_by_token"
    end
  end
end
