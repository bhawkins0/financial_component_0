# == Schema Information
#
# Table name: financial_component_accounts
#
#  id                         :integer          not null, primary key
#  fc_account_group           :string
#  fc_account_name            :string
#  fc_account_number          :integer
#  fc_account_reporting_group :string
#  fc_account_type            :boolean
#  fc_statement               :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class FinancialComponentAccount < ApplicationRecord
end
