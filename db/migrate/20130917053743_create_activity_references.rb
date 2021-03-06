class CreateActivityReferences < ActiveRecord::Migration
  def change
    create_table :activity_references do |t|
      t.integer :referenceable_id
      t.string :referenceable_type
      t.integer :activity_id
      t.string :title
    end

    add_index :activity_references, [:activity_id, :title], unique: true
    add_index :activity_references, [:referenceable_id, :referenceable_type]
  end
end
