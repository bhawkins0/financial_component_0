class AddFcTransactionSplitTemplateIdToFinancialComponentTransactionSplitTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :financial_component_transaction_split_templates, :fc_transaction_split_template_id, :integer
    add_column :financial_component_transaction_split_templates, :fc_transaction_split_id, :integer
  end
end
