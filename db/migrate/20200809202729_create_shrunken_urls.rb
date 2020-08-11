class CreateShrunkenUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :shrunken_urls do |t|
      t.string :url
      t.text :short_code

      t.timestamps
    end
  end
end
