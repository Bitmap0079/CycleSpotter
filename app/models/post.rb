class Post < ApplicationRecord
    validates :name, presence: true
    validates :name, length: { maximum: 50 }
    # validates :validate_name_not_include_comma
    belongs_to :user

    scope :recent, -> { order(created_at: :desc)}

    private
    #コンマを含めないようにするバリデーション
    def validate_name_not_include_comma
      errors.add(:name, 'にコンマを含めることはできません') if name&.include?(',')
      # &.を使っているのはnameがnilのときに例外が発生しないように(nilのときに検証が通るように)
    end
end
