class CreateFinancialComponentAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :financial_component_accounts do |t|
      t.string :fc_statement
      t.integer :fc_account_number
      t.string :fc_account_group
      t.string :fc_account_reporting_group
      t.boolean :fc_account_type
      t.string :fc_account_name

      t.timestamps
    end
  end
end
