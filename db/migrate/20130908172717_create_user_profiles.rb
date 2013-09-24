class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.text       :card_hash
      t.text       :resume_hash
      t.belongs_to :user

      t.timestamps
    end

    add_index :user_profiles, :user, :unique => true
  end
end
