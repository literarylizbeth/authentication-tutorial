module Authentication

  protected

    def current_user
      if cookies[:user_id]
        @current_user ||= User.find(cookies[:user_id])
      else
        @current_user = nil
      end
    end

    def current_user=(user)
      @current_user = user
    end

    def signed_in?
      !current_user.nil?
    end

    def sign_in(user)
      cookies.permanent[:user_id] = user.id
      current_user = user
    end

    def sign_out
      current_user = nil
      cookies.delete(:user_id)
    end

    def confirm_signed_in
      unless signed_in?
        flash[:warning] = "Please sign in to access this page."
        destination = request.get? ? request.url : ""
        redirect_to new_session_url(destination: destination)
      end
    end

    def confirm_correct_user
      unless params[:id] == cookies[:user_id]
        flash[:warning] = "You don't have permission to access this page."
        redirect_to root_url
      end
    end

end