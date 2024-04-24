class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 50, null: false
      t.string :github_username, limit: 50

      t.timestamps
    end

    add_index :users, :github_username, unique: true
  end
end
