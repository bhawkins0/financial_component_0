class AddPasswordVerifiedAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :password_verified_at, :datetime
  end
end
