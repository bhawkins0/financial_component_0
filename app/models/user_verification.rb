# == Schema Information
#
# Table name: user_verifications
#
#  id                    :integer          not null, primary key
#  email                 :string
#  email_validation_code :integer
#  mobile                :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :integer
#
class UserVerification < ApplicationRecord
    belongs_to :user, foreign_key: :user_id, primary_key: :id
end
