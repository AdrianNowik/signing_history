class SigningInHistory < ActiveRecord::Base
  belongs_to :user

  scope :active, -> { where(inactive: false) }
  scope :failed, -> { where(sign_succeed: false) }
end
