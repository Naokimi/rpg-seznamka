class CreateRulebooks < ActiveRecord::Migration[6.1]
  def change
    create_table :rulebooks do |t|
      t.string :name
      t.text :description
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
