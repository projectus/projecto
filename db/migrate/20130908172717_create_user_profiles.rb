class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.text       :card_hash
      t.text       :resume_hash
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
