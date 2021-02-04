FactoryBot.define do
  factory :task do
    title { 'task' }
    content { 'content' }
    deadline { Time.current }
    status {'New'}
    priority {'low'}

  end
end
