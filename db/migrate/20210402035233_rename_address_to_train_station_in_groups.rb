class RenameAddressToTrainStationInGroups < ActiveRecord::Migration[6.1]
  def change
    rename_column :groups, :city, :train_station
  end
end
