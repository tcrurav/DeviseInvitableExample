class CreateBicycles < ActiveRecord::Migration[6.1]
  def change
    create_table :bicycles do |t|
      t.string :brand
      t.string :model
    end
  end
end
