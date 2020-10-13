class CreateSavings < ActiveRecord::Migration[6.0]
  def change
    create_table :savings do |t|
      t.string :saved_on
      t.decimal :amount
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
