Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :clubs, only: %i[new create show index] do
    resources :memberships, only: %i[new create]
  end
end
