# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string
#  email_verified_at  :datetime
#  first_name         :string
#  last_name          :string
#  mobile             :string
#  mobile_verified_at :datetime
#  password_digest    :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  #validates :email, :presence => true
  validates :email, presence: true, unless: :mobile
  has_secure_password

   has_many(:plaid_institutions, {
    :class_name => "PlaidInstitution",
    :foreign_key => "fc_user_id"
  })
  
  has_one(:user_verification,{
    :class_name => "UserVerification",
    :foreign_key => "user_id"
  })
end
