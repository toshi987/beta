class Blog < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :title, presence: true, length: { in: 1..50 }
  validates :content, presence: true, length: { in: 1..200 }
end
