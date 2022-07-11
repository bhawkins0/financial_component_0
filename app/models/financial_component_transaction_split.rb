# == Schema Information
#
# Table name: financial_component_transaction_splits
#
#  id                               :integer          not null, primary key
#  fc_account_number                :integer
#  fc_amount                        :float
#  fc_transaction_split_type        :boolean
#  created_at                       :datetime         not null
#  updated_at                       :datetime         default(NULL), not null
#  fc_transaction_split_id          :integer
#  fc_transaction_split_template_id :integer
#  plaid_transaction_id             :string
#
class FinancialComponentTransactionSplit < ApplicationRecord
    validates(:plaid_transaction_id, { :presence => true })
    validates(:fc_transaction_split_type, { :presence => true })
    validates(:fc_transaction_split_template_id, { :presence => true })
    validates(:fc_amount, { :presence => true })
    validates(:fc_account_number, { :presence => true })
end
