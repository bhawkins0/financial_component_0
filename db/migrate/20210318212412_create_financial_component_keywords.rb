class CreateFinancialComponentKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :financial_component_keywords do |t|
      t.string :plaid_name
      t.string :plaid_merchant_name
      t.string :plaid_category
      t.integer :fc_split_id
      t.integer :transaction_cont

      t.timestamps
    end
  end
end
