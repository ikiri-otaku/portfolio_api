class AddDiscardedAtToTeches < ActiveRecord::Migration[7.1]
  def change
    add_column :teches, :discarded_at, :datetime, after: :parent_id
    add_index :teches, :discarded_at
  end
end
