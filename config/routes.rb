Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
  namespace "api" do
    namespace "v1" do
      get "/applications/:token/chats", to: "chats#show"
      get "/chats/:token/:number/messages", to: "messages#show"
      resources :applications, param: :token
      resources :chats, only: [:index, :create]
      resources :messages, only: [:index, :create] do
        collection do
          get "search"
        end
      end
    end
  end
end
