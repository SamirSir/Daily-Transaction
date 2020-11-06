class RemoveCoverPicFromProfile < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :cover_pic, :string
  end
end
