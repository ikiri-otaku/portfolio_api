class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations do |t|
      t.string :name, limit: 50, null: false
      t.string :github_username, limit: 50

      t.timestamps
    end

    add_index :organizations, :github_username, unique: true
  end
end
