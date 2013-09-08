class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :card_xml
      t.string :resume_xml
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
