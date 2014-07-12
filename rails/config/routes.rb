Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :speakers
      resources :calendars, only: [:show]
      resources :matters, only: [:index]
      resources :events, only: [:create]
      namespace :cbm do
        resources :hearings, only: [:index]
        resources :parties, only: [:index]
        resources :calendars, only: [:index]
      end
    end
  end
end
