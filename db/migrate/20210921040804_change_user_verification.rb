class ChangeUserVerification < ActiveRecord::Migration[6.0]
    #def up
    #  change_column :user_verifications, :mobile_validation_code, :datetime
    #end

    def down
      change_column :user_verifications, :mobile_validation_code, :mobile_verified_at
    end
end
