class RemoveFamilyTypeFromProfile < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :family_type, :string
  end
end
