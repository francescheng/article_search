class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :link
      t.text :body
      t.string :reading_time

      t.timestamps
    end
  end
end
