class CreateFinancialComponentTransactionSplitTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :financial_component_transaction_split_templates do |t|
      t.string :fc_transaction_split_template_name
      t.float :fc_transaction_split_percent
      t.integer :fc_account_number
      t.boolean :fc_transaction_split_type

      t.timestamps
    end
  end
end
