class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.string :gender, null: false
      t.integer :age, null: false
      t.string :profile_pic, null: true
      t.string :cover_pic, null: true
      t.boolean :married, default: false
      t.integer :children, default: 0
      t.string :family_type, default: "single"

      t.timestamps
    end
  end
end
