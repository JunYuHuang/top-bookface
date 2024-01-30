class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: "User"

  validates :body, presence: true, length: { in: 1..255 }
end
