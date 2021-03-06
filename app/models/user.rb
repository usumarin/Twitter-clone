class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:timeoutable, password_length: 6..16
  validates :name, length: { in: 1..10 }
  validates :profile, length: { maximum: 200 }
  validates :email, presence: true, uniqueness: true
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships 
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  attr_accessor :current_password
  has_one_attached :avatar

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  def user_icon
    return self.avatar.variant(resize: '80x80').processed
  end
  
  def thumbnail
    return self.avatar.variant(resize: '300x300').processed
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?

      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
  end

  private

    def avatar_type
      if !avatar.content_type.in?(%('avatar/jpeg avatar/png'))
        errors.add(:avatars, 'アップロードできるのはJPEGまたはPNGだけです')
      end
    end
end
