class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.integer :user_id
      t.string :ticker
      t.integer :shares

      t.timestamps
    end
  end
end
