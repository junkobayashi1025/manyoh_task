require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  before do
    admin_user = FactoryBot.create(:admin_user)
    visit new_session_path
    fill_in 'session[email]', with: admin_user.email
    fill_in 'session[password]', with: admin_user.password
    click_on 'session_form_submit'
    FactoryBot.create(:label_work)
    FactoryBot.create(:label_private)
    FactoryBot.create(:label_other)
  end

  describe 'ラベル登録機能' do
    before do
      visit new_task_path
      task = Task.new(title: "test", content: "content", deadline: Time.current + 7.days, status: 'New', priority: 'low')
      fill_in 'task[title]', with: task.title
      fill_in 'task[content]', with: task.content
      fill_in 'task[deadline]', with: task.deadline
      select task.status, from: 'task[status]'
      select task.priority, from: 'task[priority]'
      check 'task_label_ids_1'
      click_on 'task_form_submit'
      sleep(1)
    end
    context 'ラベルを選択し、タスクを作成した場合' do
      it '選択したラベルがタスク一覧ページに表示される' do
        visit tasks_path
        label_list = all('tbody tr')
        expect(label_list[0]).to have_content "work"
        expect(label_list[0]).not_to have_content "other"
        expect(label_list[0]).not_to have_content "private"
        end
      end
    context 'タスク一覧ページにてラベルを検索した場合' do
      it '検索したラベルに関するタスクのみが表示される' do
       visit tasks_path
       select 'work', from: 'label_id'
       click_on '検索'
       sleep(1)
       label_list = all('tbody tr')
       expect(label_list[0]).to have_content 'work'
       expect(label_list[0]).not_to have_content 'private'
       expect(label_list[0]).not_to have_content 'other'
     end
    end
    context 'タスクの編集ページにてラベルを変更した場合' do
      it '変更したラベルがタスク一覧ページに表示される' do
       visit tasks_path
        first('tbody tr').click_on '編集'
        uncheck 'work'
        check 'other'
        click_on '登録'
        sleep(1)
        label_list = all("tbody tr")
        expect(label_list[0]).to have_content'other'
        expect(label_list[0]).not_to have_content 'work'
     end
    end
  end
end
