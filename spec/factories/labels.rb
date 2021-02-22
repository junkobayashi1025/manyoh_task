FactoryBot.define do
  factory :label_work, class: Label do
    id {1}
    name { 'work' }
  end
  factory :label_private, class: Label do
    id {2}
    name { 'private' }
  end
  factory :label_other, class: Label do
    id {3}
    name { 'other' }
  end
end
