class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.string :content
      t.belongs_to :User, index: true

      t.timestamps
    end
  end
end
