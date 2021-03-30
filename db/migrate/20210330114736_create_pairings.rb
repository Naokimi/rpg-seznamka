class CreatePairings < ActiveRecord::Migration[6.1]
  def change
    create_table :pairings do |t|
      t.references :genre, null: false, foreign_key: true
      t.references :rulebook, null: false, foreign_key: true

      t.timestamps
    end
  end
end
