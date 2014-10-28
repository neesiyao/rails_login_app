class Test < ActiveRecord::Base
  has_one :invitation, dependent: :destroy
end
