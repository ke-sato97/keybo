class User < ApplicationRecord
  authenticates_with_sorcery!
	enum role: { general: 0, admin: 1, guest: 2}

  has_many :diagnoses, dependent: :destroy
  has_many :keyboards, dependent: :destroy, through: :diagnoses

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true

end
