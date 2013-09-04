class AddActiveToCollaborationApplication < ActiveRecord::Migration
  def change
    add_column :collaboration_applications, :active, :string, default: 'yes'
  end
end
