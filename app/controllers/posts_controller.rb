class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @post = Post.all.order(created_at: :desc)
  end

  def show
  end

  def create
    @post = current_user.posts.new(post_params)
    #ログイン中のユーザーが新規投稿する関連付けの書き方（オブジェクト指向っぽい書き方）
    #ログインしているユーザーのidがuser_idに入っている状態
    if @post.save
      #redirect_to @postでインスタンス変数にリダイレクトしているのは
      #posts/showのルーティングが@postで返されるため
      redirect_to @post, notice: "新規投稿が完了しました！"
    else
      render :new
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def update
    @post.update!(post_params)
    redirect_to posts_url, notice: "投稿を編集しました！"
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "投稿を削除しました！"
  end

  #ストロングパラメーターprivate
  private
  #nameとcontentは入力値を保持する必要があるのでそのメソッド
  def post_params
    params.require(:post).permit(:name, :content)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

end
