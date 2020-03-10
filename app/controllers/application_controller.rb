class ApplicationController < ActionController::Base
  #セキュリティ対策構文
  protect_from_forgery with: :exception
  #すべてのビューでcurrent_userを使うためのヘルパーメソッド
  #ログイン情報の取得をかんたんにするため
  helper_method :current_user
  #ログインを要求するために処理を行う前に入れるフィルタ
  before_action :login_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    #①User.findでも取得はできるが、findメソッドはnilのとき例外としてエラーが発生してしまう
    #そのため、例外が生じないようにこの場面ではfind_byを使用
    #②コントローラーではpublicなメソッドはアクションとしても利用できてしまうので、
    #プライベートメソッドとして使っている
    #③ifを中に入れているのはセッションが有効でない場合に取得を行わないため
  end

  def login_required
    redirect_to root_path unless current_user
  end


end
