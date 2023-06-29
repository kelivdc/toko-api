class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true
      t.boolean :active
      t.text :description
      t.string :slug
      t.string :meta_title
      t.string :meta_description
      t.string :meta_keywords

      t.timestamps
    end
  end
end
