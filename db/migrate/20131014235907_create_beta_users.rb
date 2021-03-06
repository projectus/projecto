class CreateBetaUsers < ActiveRecord::Migration
  def change
    create_table :beta_users do |t|
      t.string :email, default: '', null: false

      t.timestamps
    end
    add_index :beta_users, :email, unique: true
  end
end
