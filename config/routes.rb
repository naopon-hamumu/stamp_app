Rails.application.routes.draw do
  get 'participants/create'
  root "stamp_rallies#index"
  get "top", to: "static_pages#top"
  get "site_policy", to: "static_pages#site_policy"
  get "privacy_policy", to: "static_pages#privacy_policy"

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
  end

  resources :stamp_rallies do
    collection do
      get 'search'
    end
    resource :participant, only: %i[create destroy], module: :stamp_rallies
    resources :participants_stamps, only: [:create], module: :stamp_rallies
  end

  resources :stamps, only: %i[index]
end
