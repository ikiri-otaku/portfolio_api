class CreateOrganizationUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :organization_users do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :organization_users, [:organization_id, :user_id], unique: true
  end
end
