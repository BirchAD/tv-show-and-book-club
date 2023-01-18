class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :isbn
      t.date :published
      t.binary :image
      t.text :description
      t.string :genre

      t.timestamps
    end
  end
end
