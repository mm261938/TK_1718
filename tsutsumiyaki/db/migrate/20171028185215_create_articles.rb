class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string  :title, null: false
      t.text    :description
      t.string  :link
      t.string  :place
      t.string  :latitude
      t.string  :longitude
      t.datetime :published_at, null: false

      t.timestamps
    end
    add_index :articles, [:link], unique: true
  end
end
