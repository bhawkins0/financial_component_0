class CreatePlaidInstitutions < ActiveRecord::Migration[6.0]
  def change
    create_table :plaid_institutions do |t|
      t.string :plaid_institution_id
      t.string :plaid_name
      t.string :plaid_logo
      t.integer :fc_user_id

      t.timestamps
    end
  end
end
