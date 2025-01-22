class Book < ApplicationRecord

# bookモデルとuserモデルの関連付け
 belongs_to :user

 # プロフィール画像とユーザーの関連付け
 has_one_attached :user_image

 # title、bodyのバリデーションチェック
 validates :title, presence: true
 validates :body, length: { maximum: 200 }, presence: true

end
