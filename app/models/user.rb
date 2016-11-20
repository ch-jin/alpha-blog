class User < ActiveRecord::Base
    attr_accessor :remember_token
    has_many :articles, dependent: :destroy

    before_save { self.email = email.downcase }

    validates :username, presence: true,
        uniqueness: { case_sensitive: false },
        length: { minimum: 3, maximum: 25 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true,
        uniqueness: { case_sensitive: false },
        length: { maximum: 105 },
        format: { with: VALID_EMAIL_REGEX }

    has_secure_password

    #Return hash digest of given string
    def self.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    #Return random token
    def self.new_token
      SecureRandom.urlsafe_base64
    end

    #Remember user in database
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end

    #Return true if token matches digest
    def authenticated?(remember_token)
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # Forget user
    def forget
      update_attribute(:remember_token, nil)
    end
end
