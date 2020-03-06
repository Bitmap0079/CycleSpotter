class SessionsController < ApplicationController
  #applicationcontrollerでbefore_actionが定義されているので
  #Sessionではそれをスキップするためのbefore_actionを入れる
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
      #メールアドレスに対するユーザーが見つからないとき、userはnilになってしまう
      #よって、ぼっち演算子を使用
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトが完了しました！'
    #reset_sessionはuser_idのセッション情報だけではなく、そのセッション内全ての情報を削除できる
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
