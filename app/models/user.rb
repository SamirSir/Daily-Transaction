class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :savings, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :loans, dependent: :destroy
  
end
