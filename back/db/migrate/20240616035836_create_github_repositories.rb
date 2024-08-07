class CreateGithubRepositories < ActiveRecord::Migration[7.1]
  def change
    create_table :github_repositories do |t|
      t.references :portfolio, null: false, index: { unique: true }, foreign_key: true
      t.string :owner, limit: 50, null: false
      t.string :repo, limit: 100, null: false

      t.timestamps
    end
  end
end
