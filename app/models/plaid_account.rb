# == Schema Information
#
# Table name: plaid_accounts
#
#  id                        :integer          not null, primary key
#  fc_account_normal_balance :string
#  plaid_account_name        :string
#  plaid_account_type        :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  fc_user_id                :integer
#  plaid_account_id          :string
#  plaid_institution_id      :string
#
class PlaidAccount < ApplicationRecord
  validates(:plaid_institution_id, { :presence => true })
  validates(:plaid_account_type, { :presence => true })
  validates(:fc_account_normal_balance, { :presence => true })
  validates(:plaid_account_name, { :presence => true })
  validates(:plaid_account_id, { :presence => true })

  belongs_to(:user, {
    :foreign_key => "fc_user_id"
  })
end
