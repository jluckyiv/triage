Rails.application.routes.draw do
  namespace :api do

    namespace :v1 do
      resources :matters, only: [:index, :show]
      resources :events, only: [:create]

      namespace :triage do
        resources :matters, only: [:index, :show]
        resources :events, only: [:create]
      end

      namespace :cbm do
        resources :matters, only: [:index, :show]
        resources :calendars, only: [:index]
      end
    end
  end
end
