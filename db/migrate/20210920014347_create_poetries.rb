class CreatePoetries < ActiveRecord::Migration[6.1]
  def change
    create_table :poetries do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
