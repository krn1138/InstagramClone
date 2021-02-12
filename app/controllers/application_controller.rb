class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def move_to_signed_in
    unless logged_in?
      redirect_to  new_session_path, notice:"ログインしてください"
    end
  end
end
