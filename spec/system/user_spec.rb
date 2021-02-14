require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
    let!(:admin_user){ FactoryBot.create(:admin_user) }
    let!(:user1){ FactoryBot.create(:user1) }
    let!(:user2){ FactoryBot.create(:user2) }

  describe 'ユーザー登録機能' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        user = User.new(name: "name", email: "user@example.com", password: "password", password_confirmation: "password")
        fill_in 'user[name]', with: user.name
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password_confirmation
        click_on 'user_form_submit'
        sleep(1)
        result = User.last
        expect(find_by_id("users-show__user-#{result.id}-name")).to have_content user.name
        expect(find_by_id("users-show__user-#{result.id}-email")).to have_content user.email
        end
      end
    context 'ログインしていない場合' do
      it 'ログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移する' do
       visit tasks_path
       expect(page).to have_content 'ログインが必要です！'
       expect(current_path).to eq new_session_path
     end
    end
  end
  describe 'ログインとログアウト' do
    context 'ログインした場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: user1.email
        fill_in 'session[password]', with: user1.password
        click_on 'session_form_submit'
        sleep(1)
      end
      it '自分の詳細画面に飛ぶ' do
        expect(find_by_id("users-show__user-#{user1.id}-name")).to have_content user1.name
        expect(find_by_id("users-show__user-#{user1.id}-email")).to have_content user1.email
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        visit user_path(user2)
        expect(page).to have_content '閲覧権限がありません'
        expect(current_path).to eq tasks_path
      end
      it 'ログアウトできる' do
        click_on 'navbarDropdown'
        click_on 'header_nav_submit'
        sleep(1)
        expect(current_path).to eq new_session_path
        # expect(is_logged_in?).to be_falsy
      end
    end
  end
  describe '管理者機能' do
    context '一般ユーザーの場合' do
      it '管理画面にアクセスできない' do
        visit new_session_path
        fill_in 'session[email]', with: user1.email
        fill_in 'session[password]', with: user1.password
        click_on 'session_form_submit'
        sleep(1)
        visit admin_users_path
        expect(page).to have_content '権限がありません'
      end
    end
    context '管理者の場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: admin_user.email
        fill_in 'session[password]', with: admin_user.password
        click_on 'session_form_submit'
        sleep(1)
      end
      it '管理画面にアクセスできる' do
        visit admin_users_path
        expect(page).to have_content 'ユーザー一覧(管理者用)'
      end
      it 'ユーザーの新規登録ができる' do
        visit new_admin_user_path
        user = User.new(name: "name", email: "user@example.com", password: "password", password_confirmation: "password")
        fill_in 'user[name]', with: user.name
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password_confirmation
        click_on 'admin_user_form_submit'
        sleep(1)
        result = User.last
        expect(find_by_id("admin_user-show__user-#{result.id}-name")).to have_content user.name
        expect(find_by_id("admin_user-show__user-#{result.id}-email")).to have_content user.email
        expect(find_by_id("admin_user-show__user-#{result.id}-tasks_count")).to have_content user.tasks.count
      end
      it 'ユーザーの詳細画面にアクセスできる'do
        visit admin_users_path
        click_on "admin-index_detail-#{user1.id}-submit"
        expect(find_by_id("admin_user-show__user-#{user1.id}-name")).to have_content user1.name
        expect(find_by_id("admin_user-show__user-#{user1.id}-email")).to have_content user1.email
        expect(find_by_id("admin_user-show__user-#{user1.id}-tasks_count")).to have_content user1.tasks.count
      end
      it 'ユーザの編集画面からユーザを編集できる'do
        visit admin_users_path
        click_on "admin_index_edit-#{user1.id}-submit"
        user = User.new(name: "name3", email: "user3@example.com", password: "password3", password_confirmation: "password3")
        fill_in 'user[name]', with: user.name
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password_confirmation
        click_on 'admin_user_form_submit'
        sleep(1)
        expect(find_by_id("admin_user-show__user-#{user1.id}-name")).to have_content user.name
        expect(find_by_id("admin_user-show__user-#{user1.id}-email")).to have_content user.email
      end
      it 'ユーザーを削除できる'do
        visit admin_users_path
        click_on "admin_index_delete-#{user1.id}-submit"
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content user1.email
        expect(page).to have_content user2.email
        expect(page).to have_content admin_user.email
      end
    end
  end
end
