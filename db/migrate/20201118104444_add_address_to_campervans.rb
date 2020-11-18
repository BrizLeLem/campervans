class AddAddressToCampervans < ActiveRecord::Migration[6.0]
  def change
    add_column :campervans, :address, :string
  end
end
