class Modifymeals2 < ActiveRecord::Migration[5.2]
  def change
    add_column :meal_details, :photo_thumb, :string
  end
end
