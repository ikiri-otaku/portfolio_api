class CreateTeches < ActiveRecord::Migration[7.1]
  def change
    create_table :teches do |t|
      t.string :name, limit: 20, null: false
      t.references :parent

      t.timestamps
    end
    add_foreign_key :teches, :teches, column: :parent_id
  end
end
