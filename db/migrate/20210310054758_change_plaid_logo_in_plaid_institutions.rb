class ChangePlaidLogoInPlaidInstitutions < ActiveRecord::Migration[6.0]
  def change
    change_column :plaid_institutions, :plaid_logo, :text
  end
end
