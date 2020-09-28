class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, length: { maximum: 40 }
  validates :birth, presence: true
  PASSWORD_RULE = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_RULE, message: 'には英字と数字の両方を含めて設定してください'
  NAME_RULE = /\A[ぁ-んァ-ヶー一-龠]+\z/.freeze
  validates_format_of :family_name, with: NAME_RULE, message: 'は全角文字で設定してください'
  validates_format_of :first_name, with: NAME_RULE, message: 'は全角文字で設定してください'
  FURIGANA_NAME_RULE = /\A[ア-ン゛゜ァ-ォャ-ョー「」、]+\z/.freeze
  validates_format_of :ja_family_name, with: FURIGANA_NAME_RULE, message: 'は全角カタカナで設定してください'
  validates_format_of :ja_first_name, with: FURIGANA_NAME_RULE, message: 'は全角カタカナで設定してください'
end
