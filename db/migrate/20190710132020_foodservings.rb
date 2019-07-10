class Foodservings < ActiveRecord::Migration[5.2]
  def change
    add_column :meal_details, :unit_grams, :float
    remove_column :meal_details, :serving_weight_grams
  end
end
