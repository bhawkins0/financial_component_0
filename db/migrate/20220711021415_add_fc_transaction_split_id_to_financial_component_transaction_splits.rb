class AddFcTransactionSplitIdToFinancialComponentTransactionSplits < ActiveRecord::Migration[6.0]
  def change
    add_column :financial_component_transaction_splits, :fc_transaction_split_id, :integer
  end
end
