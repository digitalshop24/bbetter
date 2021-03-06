Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  get '/forum', to: "posts#topics"
  get '/topics/:id', to: "posts#index", as: :posts
  get '/topics/:id/post/new', to: "posts#new", as: :new_post
  get '/topics/:id/posts/:id/edit', to: "posts#edit", as: :edit_post
  get '/topics/:id/posts/:id', to: "posts#show", as: :post
  put '/topics/:id/posts/:id', to: "posts#update"
  patch '/topics/:id/posts/:id', to: "posts#update"
  post '/topics/:id', to: "posts#create"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount API::Root => '/'
  mount GrapeSwaggerRails::Engine => '/apidoc'
  devise_for :users, controllers: { sessions: "users/sessions" }
  root 'home#index'
  post '/registration', to: "home#registration", as: :home_registration
  put '/edit_profile', to: "home#edit_profile", as: :edit_profile
  put '/restore_password', to: "home#restore_password", as: :restore_password
  get '/profile', to: "home#profile", as: :profile
  get '/testcheck', to: "application#testcheck"
  post '/check', to: "yandex_kassa#testcheck"
  post '/pay', to: "yandex_kassa#testpay"
  post 'registration', to: "home#registration"
  get '/promo', to: "home#promo", as: :promo
  post '/comment/:id', to: "posts#comment"
  get '/unsubscribe', to: "home#unsubscribe", as: :unsubscribe
  post '/promo', to: "home#send_promo", as: :send_promo
  resources :messages, only: [:create]
  resources :feedbacks, only: [:create]
  resources :summaries
  resources :videos, only: [:create]

  put 'user_tariffs/:id/set_training_program', to: 'user_tariffs#set_training_program', as: :set_training_program

  controller 'yandex_kassa', constraints: { subdomain: 'ssl' } do
      post :testcheck
      post :testpay
      get :success
      get :fail
      post :fail # исключение: при неуспехе оплаты из кошелька Яндекс.Денег приходит запрос методом POST
  end

  match "/404", :to => "errors#not_found", :via => :all
end
