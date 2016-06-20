Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount API::Root => '/'
  mount GrapeSwaggerRails::Engine => '/apidoc'
  devise_for :users
  get '/testcheck', to: "application#testcheck"
  post '/testcheck', to: "application#testcheck"
  post '/testpay', to: "application#testpay"
   scope '/yandex_kassa' do
    controller 'yandex_kassa', constraints: { subdomain: 'ssl' } do
      post :check
      post :aviso
      get :success
      get :fail
      post :fail # исключение: при неуспехе оплаты из кошелька Яндекс.Денег приходит запрос методом POST
    end
  end
end
