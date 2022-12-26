class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username,
            presence: true,
            length: { in: 3..10 },
            uniqueness: { case_sensitive: false }

  validates :first_name,
            :last_name,
            presence: true,
            format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/,
                      message: 'only allows letters and one space after a letter' },
            length: { maximum: 25 }

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def initials
    first_names = first_name.split(/[\s,-]+/).map { |name| name[0] }.join.upcase
    last_names = last_name.split(/[\s,-]+/).map { |name| name[0] }.join.upcase
    "#{first_names}#{last_names}"
  end
end
