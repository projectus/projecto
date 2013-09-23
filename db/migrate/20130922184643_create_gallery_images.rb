class CreateGalleryImages < ActiveRecord::Migration
  def change
    create_table :gallery_images do |t|
      t.belongs_to :gallery_folder, index: true
      t.string :title

      t.timestamps
    end
  end
end
