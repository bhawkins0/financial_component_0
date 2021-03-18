# == Schema Information
#
# Table name: financial_component_transactions
#
#  id                   :integer          not null, primary key
#  fc_account_number    :integer
#  fc_amount            :float
#  fc_commit            :boolean
#  fc_transaction_type  :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  fc_split_id          :integer
#  fc_transaction_id    :integer
#  plaid_transaction_id :string
#
class FinancialComponentTransaction < ApplicationRecord
  validates(:plaid_transaction_id, { :presence => true })
  validates(:fc_transaction_type, { :presence => true })
  validates(:fc_commit, { :presence => true })
  validates(:fc_amount, { :presence => true })
  validates(:fc_account_number, { :presence => true })
end
