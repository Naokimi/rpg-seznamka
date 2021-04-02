class RemoveGenreFromRulebooks < ActiveRecord::Migration[6.1]
  def change
    remove_reference :rulebooks, :genre, null: false, foreign_key: true
  end
end
