class AddUserToPosts < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM posts;'
    #ここでexecuteのSQL文を入れている理由は既存の投稿がある状態で投稿とユーザーの関連
    #を表すカラム(user_id)を追加すると、既存の投稿に紐づくユーザーが見つからず
    #NOTNULL制約に引っかかてしまうため。事前に投稿を全て削除してからカラムを追加している
    add_reference :posts, :user, index: true
    #reference型を使うとuserではなくuser_idというカラム名を生成してくれる
  end

  def down
    remove_reference :posts, :user, index: true
  end
end
