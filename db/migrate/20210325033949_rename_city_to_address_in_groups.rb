class RenameCityToAddressInGroups < ActiveRecord::Migration[6.1]
  def change
    rename_column :groups, :city, :address
  end
end
