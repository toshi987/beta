class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.references :user
      t.references :group
      t.timestamps null: false
    end
  end
end