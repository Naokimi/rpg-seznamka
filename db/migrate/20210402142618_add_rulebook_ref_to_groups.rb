class AddRulebookRefToGroups < ActiveRecord::Migration[6.1]
  def change
    add_reference :groups, :rulebook, null: false, foreign_key: true
  end
end
