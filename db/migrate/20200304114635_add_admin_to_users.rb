class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    #adminをusersモデルに追加、ブール型では必ずdefaultを設定する
  end
end
