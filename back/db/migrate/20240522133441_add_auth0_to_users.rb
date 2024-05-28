class AddAuth0ToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :auth0_id, :string, after: :github_username
  end
end
