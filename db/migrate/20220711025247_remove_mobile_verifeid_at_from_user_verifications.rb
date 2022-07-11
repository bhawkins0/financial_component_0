class RemoveMobileVerifeidAtFromUserVerifications < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_verifications, :mobile_verified_at, :datetime
  end
end
