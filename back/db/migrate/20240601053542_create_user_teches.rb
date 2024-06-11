class CreateUserTeches < ActiveRecord::Migration[7.1]
  def change
    create_table :user_teches do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tech, null: false, foreign_key: true
      t.integer :exp_months_job, :limit => 1
      t.integer :exp_months_hobby, :limit => 1

      t.timestamps
    end

    add_index :user_teches, [:user_id, :tech_id], unique: true
  end
end
