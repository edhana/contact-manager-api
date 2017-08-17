class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
