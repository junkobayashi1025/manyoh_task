class Task < ApplicationRecord
 validates :title, presence: true
 validates :content, presence: true
 validates :deadline, presence: true
 validates :status, presence: true
 validates :priority, presence: true

 enum status:{New: 1, WIP: 2, Done: 3, Pending: 4}
 enum priority:{low: 1, normal: 2, high: 3}

 scope :title_search, ->(title) { where('title LIKE ?',"%#{title}%") }
 scope :status_search, ->(status) { where(status: status) }
end
