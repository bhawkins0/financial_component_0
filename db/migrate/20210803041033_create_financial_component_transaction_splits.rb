class CreateFinancialComponentTransactionSplits < ActiveRecord::Migration[6.0]
  def change
    create_table :financial_component_transaction_splits do |t|
      t.integer :plaid_transaction_id
      t.integer :fc_account_number
      t.integer :fc_transaction_split_template_id
      t.float :fc_amount
      t.boolean :fc_transaction_split_type

      t.timestamps
    end
  end
end
