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
  resources :password_resets, only: %i[new create edit update]

  resource :profile, only: %i[show edit update]

  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  get "terms_of_service", to: "static_pages#terms_of_service"
  get "privacy_policy", to: "static_pages#privacy_policy"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
