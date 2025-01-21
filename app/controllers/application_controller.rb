class ApplicationController < ActionController::Base

  #　ログインしない状態でトップページにアクセスしたときトップページにリダイレクト
  before_action :authenticate_user!, except: [:top, :about]
  # devise利用の機能（ユーザー登録等）が使われる前にonfigure_permitted_parametersメソッドが実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  # サインイン後にuser showページ遷移
  def after_sign_in_path_for(resource)
    user_path(@user.id)
  end

 # サインアウト後トップページ遷移
  def after_sign_out_path_for(resource)
    root_path
  end

  protected
  
  # ストロングパラメータと同様の機能
  # ユーザー登録(sign_up)の際に、email)のデータ操作を許可  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
