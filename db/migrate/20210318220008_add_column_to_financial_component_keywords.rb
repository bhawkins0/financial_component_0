class AddColumnToFinancialComponentKeywords < ActiveRecord::Migration[6.0]
  def change
    add_column(:financial_component_keywords, :fc_debit, :string)
    add_column(:financial_component_keywords, :fc_credit, :string)
  end
end
