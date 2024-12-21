class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :product
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

     validates :title, presence: true
     validates :body, presence: true, length: { maximum: 200 }
     validates :image, presence: true
     validates :user_id, {presence: true}
     validates :category, presence: true
     attribute :title, :string
     attribute :body, :string
     attribute :image, :string


  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    
    if search == "perfect"
      @post = Post.where("title LIKE?","#{word}")
    elsif search == "forward"
      @post = Post.where("title LIKE?","#{word}%")
    elsif search == "backward"
      @post = Post.where("title LIKE?","%#{word}")
    elsif search == "partial"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
end
