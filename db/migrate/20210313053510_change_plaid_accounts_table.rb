class ChangePlaidAccountsTable < ActiveRecord::Migration[6.0]
  def change
    change_column :plaid_accounts, :plaid_account_normal_balance, :string
  end
end
