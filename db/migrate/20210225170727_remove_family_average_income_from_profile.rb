class RemoveFamilyAverageIncomeFromProfile < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :family_average_income, :decimal
  end
end
