class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.integer :original_id
      t.string :title
      t.text :description
      t.json :location
      t.json :value
      t.datetime :original_created_at
      t.datetime :original_updated_at
      t.integer :status
      t.datetime :expiry
      t.json :reactions
      t.json :photos
      t.json :user

      t.timestamps
    end
  end
end
