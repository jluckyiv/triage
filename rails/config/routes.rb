Rails.application.routes.draw do
  namespace :api do

    namespace :v1 do
      resources :matters, only: [:index, :show]
      resources :events, only: [:create, :index]

      namespace :cbm do
        resources :hearings, only: [:index]
        resources :parties, only: [:show]
      end
    end
  end
end
