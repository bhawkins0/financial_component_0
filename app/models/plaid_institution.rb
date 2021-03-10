# == Schema Information
#
# Table name: plaid_institutions
#
#  id                   :integer          not null, primary key
#  plaid_logo           :string
#  plaid_name           :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  fc_user_id           :integer
#  plaid_institution_id :string
#
class PlaidInstitution < ApplicationRecord
end
