class Modifymeals < ActiveRecord::Migration[5.2]
  def change
    add_column :meal_details, :food_name, :string
    add_column :meal_details, :serving_unit, :string
    add_column :meal_details, :serving_qty, :integer
    add_column :meal_details, :serving_weight_grams, :integer
    add_column :meal_details, :nf_calories, :integer
    remove_column :meal_details, :detail
    remove_column :meal_details, :calories
  end
end
