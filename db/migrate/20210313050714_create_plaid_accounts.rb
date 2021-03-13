class CreatePlaidAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :plaid_accounts do |t|
      t.string :plaid_institution_id
      t.string :plaid_account_id
      t.string :plaid_account_name
      t.string :plaid_account_type
      t.string :plaid_account_normal_balance

      t.timestamps
    end
  end
end
