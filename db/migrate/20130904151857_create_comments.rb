class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :project_id
      t.integer :plus
      t.integer :minus

      t.timestamps
    end
  end
end
