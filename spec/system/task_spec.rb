require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:new_task)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in 'task[title]', with:'title'
      fill_in 'task[content]', with:'content'
      fill_in 'task[deadline]', with: Time.current + 7.days
      click_on 'save'
      expect(page).to have_content 'title'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
       task = FactoryBot.create(:task)
       visit tasks_path
       expect(page).to have_content task.title
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content 'new_task'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task)
         visit task_path(task)
         expect(page).to have_content task.content
       end
     end
  end
end
