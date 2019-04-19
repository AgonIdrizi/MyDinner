class CreateReviewReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :review_replies do |t|
      t.references :review, foreign_key: true
      t.integer :user_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
