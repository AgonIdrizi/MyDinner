class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :body
      t.integer :star_rating, default: 0

      t.timestamps
    end
  end
end
