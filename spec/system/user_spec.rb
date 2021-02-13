require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  before do
    # FactoryBot.create(:admin_user)
    FactoryBot.create(:user1)
    FactoryBot.create(:user2)
  end
  describe 'ユーザー登録機能' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        user = User.new(name: "name", email: "content@example.com", password: "password", password_confirmation: "password")
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
  # describe '一覧表示機能' do
  #   context '一覧画面に遷移した場合' do
  #     it '作成済みのタスク一覧が表示される' do
  #      visit tasks_path
  #      expect(page).to have_content 'new_task'
  #     end
  #   end
  #   context 'タスクが作成日時の降順に並んでいる場合' do
  #     it '新しいタスクが一番上に表示される' do
  #       visit tasks_path
  #       task_list = all('tbody tr')
  #       expect(task_list[0]).to have_content 'new_task'
  #       expect(task_list[1]).to have_content 'task'
  #     end
  #   end
  #   context '終了期限でソートした場合' do
  #     it 'タスクが終了期限順に並んでいる' do
  #       visit tasks_path
  #       click_on '終了期限'
  #       sleep(1)
  #       task_list = all('tbody tr')
  #       expect(task_list[0]).to have_content 'task'
  #       expect(task_list[1]).to have_content 'new_task'
  #     end
  #   end
  #   context '優先順位が高い順でソートした場合' do
  #     it 'タスクが優先順が高い順に並んでいる' do
  #       visit tasks_path
  #       click_on '優先度'
  #       sleep(1)
  #       task_list = all('tbody tr')
  #       expect(task_list[0]).to have_content 'high'
  #       expect(task_list[1]).to have_content 'low'
  #     end
  #   end
  # end
  # describe '詳細表示機能' do
  #    context '任意のタスク詳細画面に遷移した場合' do
  #      it '該当タスクの内容が表示される' do
  #        visit task_path(1)
  #        expect(page).to have_content 'task'
  #        visit task_path(2)
  #        expect(page).to have_content 'new_task'
  #      end
  #    end
  # end
end
