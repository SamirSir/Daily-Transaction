class RemoveMarriedFromProfile < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :married, :boolean
  end
end
