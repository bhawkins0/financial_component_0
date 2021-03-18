class FixTransactionCont < ActiveRecord::Migration[6.0]
  def change
    rename_column(:financial_component_keywords,:transaction_cont,:transaction_count)
  end
end