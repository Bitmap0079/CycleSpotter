require 'rails_helper'

describe '投稿機能管理', type: :system do
  let(:user_a) {FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
  let(:user_b) {FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
  let!(:post_a) {FactoryBot.create(:post, name: '最初の投稿', user: user_a)}
  let!(:post_b) {FactoryBot.create(:post, name: '2回目の投稿', user: user_a)}

  before do
      visit login_path
      fill_in 'session[email]', with: login_user.email
      fill_in 'session[password]', with: login_user.password
      click_button 'ログインする'
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it 'ホーム画面が表示される' do
        #作成済みの投稿が画面上に表示されていることを確認
        expect(page).to have_content 'さあ、スポットを登録しよう！'
        #pageに期待する　'最初のタスク'があるかどうか
      end
    end
  end

  describe '詳細表示機能(投稿が一つのとき)' do
    context 'ユーザーがログインしているとき' do
      let(:login_user) {user_a}

      before do
        visit post_path(post_a)
      end

      it 'ユーザーAが作成した投稿が表示される' do
        expect(page).to have_content '最初の投稿'
      end
    end
  end

  describe '詳細表示機能(投稿が2つのとき)' do
    context 'ユーザーがログインしているとき' do
      let(:login_user) {user_a}

      before do
        visit post_path(post_b)
      end

      it 'ユーザーが作成した投稿が表示される' do
        expect(page).to have_content '2回目の投稿'
      end
    end
  end

  describe '新規投稿機能' do
    let(:login_user) {user_a}

    before do
      visit new_post_path
      fill_in 'post[name]', with: post_name
      click_button '登録する'
    end

    context '新規投稿画面で名称を入力したとき' do
      let(:post_name) {'新規投稿のテストを書く'}

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規投稿が完了しました！'
      end
    end

    context '新規作成画面でタイトルを入力しなかったとき' do
      let(:post_name) {''}

      it 'エラーになる' do
        within '#error_explanation' do
          expect(page).to have_content 'タイトルを入力してください'
        end
      end
    end
  end

end
