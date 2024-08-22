class AddDiscardedAtToLikes < ActiveRecord::Migration[7.1]
  def change
    add_column :likes, :discarded_at, :datetime
    add_index :likes, :discarded_at
  end
end
