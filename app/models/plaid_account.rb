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
#  plaid_account_id          :string
#  plaid_institution_id      :string
#
class PlaidAccount < ApplicationRecord
  validates(:plaid_institution_id, { :presence => true })
  validates(:plaid_account_type, { :presence => true })
  validates(:fc_account_normal_balance, { :presence => true })
  validates(:plaid_account_name, { :presence => true })
  validates(:plaid_account_id, { :presence => true })

  has_many(:transactions, {
    :class_name => "PlaidTransaction",
    :foreign_key => "plaid_account_id	"
  })
end
