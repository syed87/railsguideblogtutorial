class Article < ApplicationRecord
  include Visible
  has_rich_text :content
  has_one_attached :image
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
