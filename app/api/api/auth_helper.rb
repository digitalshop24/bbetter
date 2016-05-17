module API
  module AuthHelper
    def warden
      env['warden']
    end

    def authenticated
      return true if warden.authenticated?
      !headers['Auth-Token'].to_s.empty? && @user = User.find_by_auth_token(headers['Auth-Token'])
    end

    def current_user
      @user || warden.user
    end

    def sign_out(resource_or_scope = nil)
      #return sign_out_all_scopes unless resource_or_scope
      scope = Devise::Mapping.find_scope!(resource_or_scope)
      user = warden.user(scope: scope, run_callbacks: false) || current_user # If there is no user

      warden.raw_session.inspect # Without this inspect here. The session does not clear.
      warden.logout(scope)
      warden.clear_strategies_cache!(scope: scope)
      instance_variable_set(:"@current_#{scope}", nil)

      user.update_column(:auth_token, nil)
      !!user
    end

    def sign_in(resource_or_scope, *args)
      options  = args.extract_options!
      scope    = Devise::Mapping.find_scope!(resource_or_scope)
      resource = args.last || resource_or_scope
      if warden.user(scope) == resource && !options.delete(:force)
        true
      else
        warden.set_user(resource, options.merge!(scope: scope))
      end
    end
  end
end
