FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'task' }
    content { 'content' }
    status {'status'}
    priority {'priority'}
    deadline { Time.current }
  end
end
