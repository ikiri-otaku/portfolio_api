class CreatePortfolios < ActiveRecord::Migration[7.1]
  def change
    create_table :portfolios do |t|
      t.references :user, null: false, foreign_key: true
      t.references :organization, foreign_key: true
      t.string :name, limit: 50, null: false
      t.string :url, limit: 255, null: false
      t.text :introduction
      t.integer :unhealthy_cnt, default: 0, limit: 1
      t.datetime :latest_health_check_time

      t.timestamps
    end
  end
end
