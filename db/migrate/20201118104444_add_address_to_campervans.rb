class AddAddressToCampervans < ActiveRecord::Migration[6.0]
  def change
    add_column :campervans, :Address, :string
  end
end
