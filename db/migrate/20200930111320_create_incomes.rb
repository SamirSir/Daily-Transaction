class CreateIncomes < ActiveRecord::Migration[6.0]
  def change
    create_table :incomes do |t|
      t.string :source
      t.decimal :amount
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
