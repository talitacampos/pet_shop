class CreateDogs < ActiveRecord::Migration[5.0]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.string :genre
      t.boolean :castrated
      t.date :birth
      t.string :owner_name
      t.string :owner_phone
      t.date :last_visit

      t.timestamps
    end
  end
end
