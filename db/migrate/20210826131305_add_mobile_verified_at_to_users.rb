class AddMobileVerifiedAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mobile_verified_at, :datetime
  end
end
