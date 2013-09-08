class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :card_xml
      t.string :resume_xml
      t.belongs_to :User, index: true

      t.timestamps
    end
  end
end
