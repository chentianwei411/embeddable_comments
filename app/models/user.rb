class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :notifications, foreign_key: :recipient_id
  has_many :services

  store :settings, accessors: [:weekly_email, :monthly_newsletter], coder: JSON
  
end
