class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :card_hash
      t.string :resume_hash
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
