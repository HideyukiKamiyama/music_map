Rails.application.routes.draw do
  root "static_pages#top"

  resources :users, only: %i[new create]
  resources :spots do
    resources :comments, only: %i[create destroy], shallow: true
    collection do
      get :bookmarks
      get :autocomplete
    end
  end
  resources :bookmarks, only: %i[create destroy]

  resource :profile, only: %i[show edit update]

  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  get "terms_of_service", to: "static_pages#terms_of_service"
  get "privacy_policy", to: "static_pages#privacy_policy"
end
