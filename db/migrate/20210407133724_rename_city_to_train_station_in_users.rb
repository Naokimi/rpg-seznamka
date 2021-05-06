class RenameCityToTrainStationInUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :city, :train_station
  end
end
