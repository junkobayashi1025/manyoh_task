require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:new_task)
  end
  describe 'タスク管理機能', type: :system do
    describe '検索機能' do
      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞りこまれる" do
          visit tasks_path
          fill_in 'title', with: 'ta'
          click_on 'Search'
          expect(page).to have_content 'task'
        end
      end
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          visit tasks_path
          select 'New', from: 'status'
          click_on 'Search'
          sleep(1)
          expect(page).to have_content 'New'
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          visit tasks_path
          fill_in 'title', with: 'ta'
          select 'New', from: 'status'
          click_on 'Search'
          sleep(1)
          expect(page).to have_content 'task'
          expect(page).to have_content 'New'
        end
      end
    end
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in 'task[title]', with:'テスト'
      fill_in 'task[content]', with:'content'
      fill_in 'task[deadline]', with: Time.current + 7.days
      select 'New', from: 'task[status]'
      click_on 'save'
      sleep(1)
      expect(page).to have_content 'テスト'
      expect(page).to have_content 'New'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
       visit tasks_path
       expect(page).to have_content 'new_task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content 'new_task'
        expect(task_list[1]).to have_content 'task'
      end
    end
    context '終了期限でソートした場合' do
      it 'タスクが終了期限順に並んでいる' do
        visit tasks_path
        click_on '終了期限'
        sleep(1)
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content 'task'
        expect(task_list[1]).to have_content 'new_task'
      end
    end
    context '優先順位が高い順でソートした場合' do
      it 'タスクが優先順が高い順に並んでいる' do
        visit tasks_path
        click_on '優先度'
        sleep(1)
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content 'high'
        expect(task_list[1]).to have_content 'low'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         visit task_path(1)
         expect(page).to have_content 'task'
         visit task_path(2)
         expect(page).to have_content 'new_task'
       end
     end
  end
end
