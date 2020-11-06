class RemoveProfilePicFromProfile < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :profile_pic, :string
  end
end
