class CreateCampervans < ActiveRecord::Migration[6.0]
  def change
    create_table :campervans do |t|
      t.string :title
      t.text :description
      t.string :brand
      t.string :model
      t.integer :capacity
      t.integer :price_per_night
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
