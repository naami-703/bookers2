class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# 投稿とユーザーの関連付け
  has_many :books, dependent: :destroy
# プロフィール画像とユーザーの関連付け
  has_one_attached :user_image

# プロフィール画像がない時の設定(no-imageに設定）
def get_user_image(width, height)
  @user_image ||= user_image
  unless @user_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    @user_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    @user_image.variant(resize_to_limit: [width,height]).processed
end

# nameの空欄NG（バリデーションチェック）
 validates :name, presence: true

end
