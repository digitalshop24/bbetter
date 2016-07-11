class ErrorsController < ApplicationController
  def not_found
    @user = User.new
    render(:status => 404)
  end

  def internal_server_error
  end
end
