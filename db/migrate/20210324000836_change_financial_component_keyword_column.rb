class ChangeFinancialComponentKeywordColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :financial_component_keywords, :fc_debit, :integer
    change_column :financial_component_keywords, :fc_credit, :integer
  end
end
