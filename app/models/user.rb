class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# 投稿とユーザーの関連付け
  has_many :books, dependent: :destroy
# プロフィール画像とユーザーの関連付け
  has_one_attached :profile_image

# プロフィール画像がない時の設定(no-imageに設定）
def get_user_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    profile_image.variant(resize_to_limit: [width,height]).processed
end

# nameの空欄NG（バリデーションチェック）
 validates :name, uniqueness: true, length: { in: 2..20 }, presence: true
 validates :introduction, length: { maximum: 50 }
end
