class Club < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { in: 3..15 }
end
