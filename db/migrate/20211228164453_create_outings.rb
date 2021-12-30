class CreateOutings < ActiveRecord::Migration[5.2]
  def change
    create_table :outings do |t|
      t.string :description
      t.string :location

      t.timestamps
    end
  end
end
