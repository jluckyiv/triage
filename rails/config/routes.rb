Rails.application.routes.draw do
  namespace :api do

    namespace :v1 do
      resources :matters, only: [:index, :show]
      resources :events, only: [:create, :index]

      namespace :triage do
        resources :matters, only: [:index, :show]
        resources :events, only: [:create, :index, :destroy]
      end

      namespace :cbm do
        resources :triage_hearings, only: [:index, :show]
        resources :hearings, only: [:index]
        resources :parties,  only: [:index, :show]
      end
    end
  end
end
