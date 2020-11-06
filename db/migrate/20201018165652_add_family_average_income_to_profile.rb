class AddFamilyAverageIncomeToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :family_average_income, :decimal, default: 0
  end
end
