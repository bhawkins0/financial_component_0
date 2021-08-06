class ChangeFinancialComponentKeywordColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :financial_component_keywords, :fc_debit, "integer USING NULLIF(fc_debit, '')::int"
    change_column :financial_component_keywords, :fc_credit, "integer USING NULLIF(fc_credit, '')::int"
  end
end
