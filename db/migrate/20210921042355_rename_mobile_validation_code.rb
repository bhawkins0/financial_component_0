class RenameMobileValidationCode < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_verifications, :mobile_validation_code, :mobile_verified_at
  end
end
