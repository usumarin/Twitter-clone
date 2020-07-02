class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :User
  has_many :tweets, dependent: :destroy
  attr_accessor :current_password
  has_one_attached :avatar

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_uesr.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def thumbnail
    return self.avatar.variant(resize: '300x300').processed
  end

  private

    def avatar_type
      if !avatar.content_type.in?(%('avatar/jpeg avatar/png'))
        errors.add(:avatars, 'アップロードできるのはJPEGまたはPNGだけです')
      end
    end
end
