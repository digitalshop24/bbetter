class Users::SessionsController < Devise::SessionsController
  def auth_options
    flash[:modal] = 'signInModal'
    flash[:new_solution_errors] = ["Неверный email либо пароль"]
    { scope: resource_name, recall: "home#index" }
  end
  def create
    super
    flash = nil
  end
end
