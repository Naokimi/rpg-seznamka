class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.string :city
      t.jsonb :session_times
      t.references :gm, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
