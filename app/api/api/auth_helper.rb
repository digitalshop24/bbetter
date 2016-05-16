module API
  module AuthHelper
    def authenticated
      current_user.present?
    end

    def current_user
      User.find_by_auth_token(headers['Auth-Token'])
    end

    def sign_out
      user = current_user
      user.update_column(:authentication_token, nil)
      !!user
    end
  end
end
