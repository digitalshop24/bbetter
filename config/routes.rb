Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount API::Root => '/'
  mount GrapeSwaggerRails::Engine => '/apidoc'
  devise_for :users, controllers: { sessions: "users/sessions" }
  root 'home#index' 
  post '/registration', to: "home#registration", as: :home_registration
  put '/edit_profile', to: "home#edit_profile", as: :edit_profile
  get '/profile', to: "home#profile", as: :profile
  get '/testcheck', to: "application#testcheck"
  post '/check', to: "yandex_kassa#testcheck"
  post '/pay', to: "yandex_kassa#testpay"
  post 'registration', to: "home#registration"
  controller 'yandex_kassa', constraints: { subdomain: 'ssl' } do
      post :testcheck
      post :testpay
      get :success
      get :fail
      post :fail # исключение: при неуспехе оплаты из кошелька Яндекс.Денег приходит запрос методом POST
  end
end
