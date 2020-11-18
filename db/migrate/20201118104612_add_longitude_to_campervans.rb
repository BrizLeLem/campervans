class AddLongitudeToCampervans < ActiveRecord::Migration[6.0]
  def change
    add_column :campervans, :longitude, :float
  end
end
