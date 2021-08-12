class ChangeFinancialComponentTransactionSplits < ActiveRecord::Migration[6.0]
  def change
    change_column :financial_component_transaction_splits, :plaid_transaction_id, :string
  end
end
