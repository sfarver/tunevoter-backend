class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.string :sign_up_link
      t.timestamps
    end
  end
end
