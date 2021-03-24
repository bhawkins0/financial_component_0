# == Schema Information
#
# Table name: financial_component_keywords
#
#  id                  :integer          not null, primary key
#  fc_credit           :integer
#  fc_debit            :integer
#  plaid_category      :string
#  plaid_merchant_name :string
#  plaid_name          :string
#  transaction_count   :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  fc_split_id         :integer
#
class FinancialComponentKeyword < ApplicationRecord
end
