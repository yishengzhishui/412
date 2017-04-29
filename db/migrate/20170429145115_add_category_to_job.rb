class AddCategoryToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :category, :string
    add_column :jobs, :city, :string
  end
end
