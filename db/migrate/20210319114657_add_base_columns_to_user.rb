class AddBaseColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nickname, :string
    add_column :users, :availability, :jsonb
    add_column :users, :city, :string
  end
end
