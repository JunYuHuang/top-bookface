class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :likes

  validates :body, presence: true, length: { in: 1..255 }
end