FactoryBot.define do
  factory :task  do
    id {1}
    title { 'task' }
    content { 'content' }
    deadline { Time.current + 30.days }
    status {'New'}
    priority {'high'}
  end
  factory :new_task, class: Task do
    id {2}
    title { 'new_task' }
    content { 'content2' }
    deadline { Time.current }
    status {'New'}
    priority {'low'}
  end
end
