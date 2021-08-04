class RemoveFcSplitIdFromProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :financial_component_transactions, :fc_split_id, :integer
  end
end
