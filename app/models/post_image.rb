class PostImage < ApplicationRecord
  # モデルにimageを許可する
  has_one_attached :image

  belongs_to :user
  has_many :post_comments ,dependent: :destroy
  has_many :favorites, dependent: :destroy

  # バリデーションの設定
  validates :shop_name,presence: true
  validates :image,presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  def get_image
    unless image.attached?
      file_path=Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path),filename:'default-image.jpg',content_type:'image/jpeg')
    end
    image
  end

  # 引数で渡されたユーザidがfavorite tableに存在するかどうかを
  # def favorited_by?(user)
  #   favorites.exists?(user_id: user.id)
  # end
end
