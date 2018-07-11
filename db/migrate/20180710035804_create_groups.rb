class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :groupname
      t.text :content
      t.references :user
      t.timestamps null: false
    end
  end
end
