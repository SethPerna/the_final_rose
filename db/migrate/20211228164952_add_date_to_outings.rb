class AddDateToOutings < ActiveRecord::Migration[5.2]
  def change
    add_column :outings, :date, :string
  end
end
