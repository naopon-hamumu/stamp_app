Rails.application.routes.draw do
  root "static_pages#top"
  get "sitepolicy", to: "static_pages#sitepolicy"
  get "privacypolicy", to: "static_pages#privacypolicy"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    get "signup", to: "users/registrations#new"
    get "login", to: "users/sessions#new"
    # get "logout", to: "users/sessions#destroy"
  end

  resources :stamp_rallies
end
