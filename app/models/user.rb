# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :confirmable
  # :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email, format: URI::MailTo::EMAIL_REGEXP

  enum role: { user: 0, admin: 1 }

  has_many :complaints
  has_one_attached :avatar

  scope :confirmed, -> { where.not(confirmed_at: nil) }
  scope :admin, -> { where(role: :admin) }

  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    user = User.find_for_authentication(email:)
    user&.valid_password?(password) ? user : nil
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.avatar_url = auth.info.image

      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
      user.skip_confirmation!
    end
  end

  def self.authorize_from_external(params)
    puts params
  end
end
