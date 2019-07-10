class Foodcalories < ActiveRecord::Migration[5.2]
  def change
    add_column :meal_details, :unit_calories, :float
    remove_column :meal_details, :nf_calories
  end
end
