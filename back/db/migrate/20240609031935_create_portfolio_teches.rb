class CreatePortfolioTeches < ActiveRecord::Migration[7.1]
  def change
    create_table :portfolio_teches do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.references :tech, null: false, foreign_key: true

      t.timestamps
    end

    add_index :portfolio_teches, [:portfolio_id, :tech_id], unique: true
  end
end
