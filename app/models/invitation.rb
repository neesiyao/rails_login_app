class Invitation < ActiveRecord::Base
  belongs_to :test
  default_scope -> { order('created_at DESC') }
  validates :test_id, presence: true
  validates :email, presence: true
end
