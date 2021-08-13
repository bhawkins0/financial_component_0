class ChangeAllTables < ActiveRecord::Migration[6.0]
  def change
    change_column :financial_component_accounts, :created_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }
    change_column :financial_component_accounts, :updated_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }

    change_column :financial_component_keywords, :created_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }
    change_column :financial_component_keywords, :updated_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }

    change_column :financial_component_transaction_split_templates, :created_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }
    change_column :financial_component_transaction_split_templates, :updated_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }    

    change_column :financial_component_transaction_splits, :created_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }
    change_column :financial_component_transaction_splits, :updated_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }
    
    change_column :financial_component_transactions, :created_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }
    change_column :financial_component_transactions, :updated_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }
  end
end
