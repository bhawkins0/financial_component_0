class AddFcTransactionIdToFinancialComponentTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :financial_component_transactions, :fc_transaction_id, :integer
  end
end
