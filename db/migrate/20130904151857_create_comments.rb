class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text       :content
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true
      t.integer    :plus
      t.integer    :minus

      t.timestamps
    end
  end
end
