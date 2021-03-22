class AddImageUrlToRulebooks < ActiveRecord::Migration[6.1]
  def change
    add_column :rulebooks, :img_url, :string
  end
end
