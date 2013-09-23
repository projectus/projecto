class CreateGalleryFolders < ActiveRecord::Migration
  def change
    create_table :gallery_folders do |t|
      t.belongs_to :gallery, index: true
      t.string :name

      t.timestamps
    end
  end
end
