class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.text :introduction
      t.string :location
      t.string :company
      t.boolean :hireable, default: true, null: false
      t.string :work_location
      t.string :x_username, limit: 50
      t.string :zenn_url
      t.string :qiita_url
      t.string :atcoder_username, limit: 50

      t.timestamps
    end

    add_index :profiles, :x_username, unique: true
    add_index :profiles, :zenn_url, unique: true
    add_index :profiles, :qiita_url, unique: true
    add_index :profiles, :atcoder_username, unique: true
  end
end
