class AddLatitudeToCampervans < ActiveRecord::Migration[6.0]
  def change
    add_column :campervans, :latitude, :float
  end
end
