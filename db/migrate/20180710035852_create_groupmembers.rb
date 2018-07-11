class CreateGroupmembers < ActiveRecord::Migration[5.1]
  def change
    create_table :groupmembers do |t|
      t.references :user
      t.references :group
      t.timestamps null: false
    end
  end
end
