class RemoveShorCodeFromShrunkenUrls < ActiveRecord::Migration[6.0]
  def change
    remove_column :shrunken_urls, :shor_code, :string
  end
end
