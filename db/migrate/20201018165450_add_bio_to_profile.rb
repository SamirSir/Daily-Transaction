class AddBioToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :bio, :string, null: true
  end
end
