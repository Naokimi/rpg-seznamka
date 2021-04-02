class AddCoordinatesToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :latitude, :float
    add_column :groups, :longitude, :float
  end
end
