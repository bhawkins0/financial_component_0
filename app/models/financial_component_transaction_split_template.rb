# == Schema Information
#
# Table name: financial_component_transaction_split_templates
#
#  id                                 :integer          not null, primary key
#  fc_account_number                  :integer
#  fc_transaction_split_percent       :float
#  fc_transaction_split_template_name :string
#  fc_transaction_split_type          :boolean
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#
class FinancialComponentTransactionSplitTemplate < ApplicationRecord
    validates(:fc_transaction_split_template_name, { :presence => true })
end
