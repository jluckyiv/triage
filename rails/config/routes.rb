Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :speakers
      resources :calendars, only: [:show]
      resources :matters, only: [:show]
      resources :events, only: [:create]
    end
  end
end
