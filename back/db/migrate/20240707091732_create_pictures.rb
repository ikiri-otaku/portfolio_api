class CreatePictures < ActiveRecord::Migration[7.1]
  def change
    create_table :pictures do |t|
      t.references :imageable, polymorphic: true
      t.string :object_key

      t.timestamps
    end
  end
end
