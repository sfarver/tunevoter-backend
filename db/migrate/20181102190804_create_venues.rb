class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.string :slug
      t.string :email
      t.string :password_digest
      t.timestamps
    end
  end
end
