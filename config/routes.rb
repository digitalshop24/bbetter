Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount API::Root => '/'
  mount GrapeSwaggerRails::Engine => '/apidoc'
  devise_for :users
end
