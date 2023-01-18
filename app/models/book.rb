class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :description, presence: true
  validates :genre, presence: true
  validates :published, presence: true, comparison: { less_than: Date.today }
  validates :image, presence: true
  validates :isbn,
            presence: true,
            uniqueness: true,
            format: { with: /\A(97(8|9))?\d{9}-?[\dX]?\z/, message: 'isbn is invalid, must isbn 10 or 13 format' }
end
