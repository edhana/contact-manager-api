Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :contacts, only: [:create, :update, :destroy]
      get "/hello", to: "contacts#hello"
    end
  end
end
