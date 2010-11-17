module SessionsHelper
  USE_SESSION = true
  def sign_in(u)
    if USE_SESSION
      session[:remember_token] = [u.id, u.salt]
    else
      cookies.permanent.signed[:remember_token] = [u.id, u.salt]
    end
    current_user = u
  end

  def sign_out
    if USE_SESSION
      session[:remember_token] = nil
    else
      cookies.delete(:remember_token)  
    end    
    current_user = nil
  end

  def current_user=(u)
    @current_user = u
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def signed_in?
    !current_user.nil?
  end

  private
  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end

  def remember_token
    if USE_SESSION
      session[:remember_token] || [nil,nil]
    else
      cookies.signed[:remember_token] || [nil, nil]
    end
  end
end
