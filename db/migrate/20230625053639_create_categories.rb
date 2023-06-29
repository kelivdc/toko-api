class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :active
      t.string :description
      t.string :slug

      t.timestamps
    end
  end
end
