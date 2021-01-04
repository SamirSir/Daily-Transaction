class AddGroupToIncome < ActiveRecord::Migration[6.0]
  def change
    add_reference :incomes, :group, null: false, foreign_key: true, default: 0
  end
end
