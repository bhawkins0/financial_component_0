class CreatePlaidTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :plaid_transactions do |t|
      t.string :plaid_account_id
      t.date :plaid_authorized_date
      t.date :plaid_date
      t.string :plaid_name
      t.float :plaid_amount
      t.string :plaid_iso_currency_code
      t.string :plaid_category
      t.string :plaid_merchant_name
      t.string :plaid_address
      t.string :plaid_city
      t.string :plaid_region
      t.string :plaid_postal_code
      t.string :plaid_country
      t.float :plaid_latitude
      t.float :plaid_longitude
      t.string :plaid_transaction_id

      t.timestamps
    end
  end
end
