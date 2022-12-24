class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def initials
    first_names = first_name.split(/[\s,-]+/).map { |name| name[0] }.join.upcase
    last_names = last_name.split(/[\s,-]+/).map { |name| name[0] }.join.upcase
    "#{first_names}#{last_names}"
  end
end
