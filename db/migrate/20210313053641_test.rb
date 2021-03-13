class Test < ActiveRecord::Migration[6.0]
  def change
    rename_column :plaid_accounts, :plaid_account_normal_balance, :fc_account_normal_balance
  end
end
