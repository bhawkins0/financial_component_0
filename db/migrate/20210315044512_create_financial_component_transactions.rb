class CreateFinancialComponentTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :financial_component_transactions do |t|
      t.string :plaid_transaction_id
      t.integer :fc_split_id
      t.float :fc_amount
      t.integer :fc_account_number
      t.boolean :fc_transaction_type
      t.boolean :fc_commit

      t.timestamps
    end
  end
end
