class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :nickname, presence: true          
         validates :first_name, presence: true, format: { with: /\A[\p{Hiragana}\p{Katakana}\p{Han}]+\z/, message: 'はひらがな、カタカナ、漢字のみで入力してください' }
         validates :last_name, presence: true,  format:{ with: /\A[\p{Hiragana}\p{Katakana}\p{Han}]+\z/, message: 'はひらがな、カタカナ、漢字のみで入力してください' }
         validates :first_name_kana, presence: true, format: { with: /\A[\p{Katakana}\p{Blank}ー－]+\z/, message: 'は全角カタカナで入力してください' }
         validates :last_name_kana, presence: true, format: { with: /\A[\p{Katakana}\p{Blank}ー－]+\z/, message: 'は全角カタカナで入力してください' }
         validates :birth_day, presence: true

         PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
         validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

end

