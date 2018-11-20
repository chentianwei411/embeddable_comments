class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_many :notifications, foreign_key: :recipient_id
  has_many :services

  has_many :referral_users, class_name: "User", foreign_key: :referred_by_id
  belongs_to :referred_by, class_name: "User", optional: true

  before_create :set_referral_code
  after_create :complete_referral


  def set_referral_code
    loop do
      self.referral_code = SecureRandom.hex(6)

      if self.class.exists?(referral_code: referral_code)
        next
      else
        break
      end
    end
  end

  def complete_referral
    update(referral_completed_at: Time.zone.now)
    # 添加后续操作，比如发送邮件。
  end
end
