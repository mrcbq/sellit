class Product < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_full_text, against: {
    title: 'A',
    description: 'B'
  }

  has_one_attached :photo

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true

  ORDER_BY= {
        newest: "created_at DESC",
        expensive: "price DESC",
        cheaper: "price ASC"
    }

  belongs_to :category
end
