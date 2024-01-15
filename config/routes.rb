Rails.application.routes.draw do
  root "static_pages#top"

  resources :users, only: %i[new create]
  resources :spots, except: %i[destroy] do
    resources :comments, except: %i[index], shallow: true
    collection do
      get :bookmarks
    end
  end
  resources :comments, only: %i[index]
  resources :bookmarks, only: %i[create destroy]

  resource :profile, only: %i[show edit update]

  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
end
