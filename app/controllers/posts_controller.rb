class PostsController < ApplicationController
  def index
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update!(post_params)
    redirect_to posts_url, notice: "投稿を編集しました！"
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: "投稿を削除しました！"
  end

  #ストロングパラメーターprivate
  private
  #nameとcontentは入力値を保持する必要があるのでそのメソッド
  def post_params
    params.require(:post).permit(:name, :content)
  end

end
