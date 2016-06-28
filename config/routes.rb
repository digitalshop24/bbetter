Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount API::Root => '/'
  mount GrapeSwaggerRails::Engine => '/apidoc'
  devise_for :users
  root 'home#index'
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
