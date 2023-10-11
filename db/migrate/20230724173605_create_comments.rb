class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :post, null: false, foreign_key: {on_delete: :cascade}
      t.text :content
      t.integer :rating
      t.references :user, null: false, foreign_key: {on_delete: :cascade}


      t.timestamps
    end
  end
end


# foreign_key: {on_delete: :cascade} should operate to make all comments delete with the deletion of a single post