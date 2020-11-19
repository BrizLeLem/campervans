class AddFeaturesToCampervans < ActiveRecord::Migration[6.0]
  def change
    add_column :campervans, :features, :text
  end
end
