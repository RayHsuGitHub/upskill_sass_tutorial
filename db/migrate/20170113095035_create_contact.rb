class CreateContact < ActiveRecord::Migration[5.0]
  def change
    create_table :contact do |t|
      t.string :name
      t.string :LastName
      t.string :email
      t.text :comments
      t.timestamps
    end
  end
end