class CreateUserVerifications < ActiveRecord::Migration[6.0]
  def change
    create_table :user_verifications do |t|
      t.integer :user_id
      t.string :email
      t.integer :email_validation_code
      t.string :mobile
      t.integer :mobile_validation_code

      t.timestamps
    end
  end
end
