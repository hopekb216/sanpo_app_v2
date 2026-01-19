Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :posts
  resources :courses
  resources :users, only: [:show]

  root "home#index"
  get "home/top", to: "home#top"
  get "terms", to: "home#terms"
  get "privacy", to: "home#privacy"
  get "contact", to: "home#contact"
  get "/sign_out", to: redirect("/")
  get "mypage", to: "users#mypage"
end
