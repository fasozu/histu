class AddIndexToShrunkenUrl < ActiveRecord::Migration[6.0]
  def change
    add_column :shrunken_urls, :shor_code, :string
    add_index :shrunken_urls, :shor_code, unique: true
  end
end
