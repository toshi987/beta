class Group < ApplicationRecord
  has_many :blogs, dependent: :destroy
  has_many :blog_users, through: :blogs, source: :user
  validates :groupname, presence: true, length: { in: 1..50 }
  validates :content, presence: true, length: { in: 1..200 }
end