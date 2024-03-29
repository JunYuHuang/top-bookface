class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :likes
  has_many :comments

  validates :body, presence: true, length: { in: 1..255 }
end
