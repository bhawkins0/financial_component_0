class AddPartNumberToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :plaid_accounts, :fc_user_id, :integer
  end
end
