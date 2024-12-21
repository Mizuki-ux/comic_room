class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         attr_accessor :username
         attribute :name, :string
        #  has_many :posts, dependent: :destroy
          has_many :posts, dependent: :destroy
          has_many :post_comments, dependent: :destroy
          has_many :favorites, dependent: :destroy
        
         has_one_attached :profile_image
         validates :name, uniqueness: true, length: { in: 2..20 }
         validates :email, presence: true
        #  validates :password, presence: true
         validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

          # パスワードの長さのバリデーション（deviseが既に設定しているがカスタマイズしたい場合）
         validates :password, length: { minimum: 6 }, allow_nil: true
         validates :search, presence: true

 def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
 end

 def self.looks(search, word)
    if search == "perfect"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end 
end