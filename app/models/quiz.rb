class Quiz < ActiveRecord::Base
  has_many :invitations, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
end
