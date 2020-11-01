class CreateShortUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :short_urls do |t|
      t.string :title
      t.string :slug
      t.string :original_url
      t.integer :click_count, default: 0
      t.timestamps
    end
  end
end
