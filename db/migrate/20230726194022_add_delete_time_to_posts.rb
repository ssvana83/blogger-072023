class AddDeleteTimeToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :delete_time, :datetime
  end
end
