class Users::SessionsController < Devise::SessionsController
  def auth_options
    flash[:modal] = 'signInModal'
    { scope: resource_name, recall: "home#index" }
  end
  def create
    super
    flash[:modal] = nil
  end
end
