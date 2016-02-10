class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, length: 20
      t.integer :user_id
      t.boolean :active, default: false
      t.timestamps
    end
  end
end
