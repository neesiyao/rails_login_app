class Invitation < ActiveRecord::Base
  belongs_to :quiz
  default_scope -> { order('created_at DESC') }
  validates :quiz_id, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
                    # uniqueness: { case_sensitive: false }
end
