class Exercise < ActiveRecord::Migration[5.2]
  def change
    add_column :exercise_details, :name, :string
    add_column :exercise_details, :unit_calories, :float
    add_column :exercise_details, :duration_min, :integer
    add_column :exercise_details, :photo_thumb, :string
    remove_column :exercise_details, :detail
    remove_column :exercise_details, :calories
  end
end
