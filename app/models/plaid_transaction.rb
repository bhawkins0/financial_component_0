# == Schema Information
#
# Table name: plaid_transactions
#
#  id                      :integer          not null, primary key
#  plaid_address           :string
#  plaid_amount            :float
#  plaid_authorized_date   :date
#  plaid_category          :string
#  plaid_city              :string
#  plaid_country           :string
#  plaid_date              :date
#  plaid_iso_currency_code :string
#  plaid_latitude          :float
#  plaid_longitude         :float
#  plaid_merchant_name     :string
#  plaid_name              :string
#  plaid_postal_code       :string
#  plaid_region            :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  plaid_account_id        :string
#  plaid_transaction_id    :string
#
class PlaidTransaction < ApplicationRecord
  validates(:plaid_transaction_id, { :presence => true })
  validates(:plaid_name, { :presence => true })
  validates(:plaid_date, { :presence => true })
  validates(:plaid_amount, { :presence => true })
  validates(:plaid_account_id, { :presence => true })
end
