class AddIndexToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :category, :string
    add_index :articles, [:title], unique: true
  end
end
