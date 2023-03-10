Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :clubs, only: %i[new create show index destroy] do
    resources :memberships, only: %i[new create]
  end
  get "/profile", to: "users#show"
end
