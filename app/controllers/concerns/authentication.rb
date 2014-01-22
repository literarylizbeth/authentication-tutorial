module Authentication

  protected

    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
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
      session[:user_id] = user.id
      current_user = user
    end

    def sign_out
      session[:user_id] = nil
      current_user = nil
    end

    def confirm_signed_in
      unless signed_in?
        flash[:warning] = "Please sign in to access this page."
        destination = request.get? ? request.url : ""
        redirect_to new_session_url(destination: destination)
      end
    end

    def confirm_correct_user
      unless params[:id] == session[:user_id]
        flash[:warning] = "You don't have permission to access this page."
        redirect_to root_url
      end
    end

end