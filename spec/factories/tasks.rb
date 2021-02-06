FactoryBot.define do
  factory :task  do
    title { 'task' }
    content { 'content' }
    deadline { Time.current }
    status {'New'}
    priority {'low'}
  end
  factory :new_task, class: Task do
    title { 'new_task' }
    content { 'content2' }
    deadline { Time.current + 30.days}
    status {'New'}
    priority {'low'}
end
end
