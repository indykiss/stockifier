class CreatePortfolios < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolios do |t|
      t.integer :user_id
      t.string :ticker
      t.integer :price
      t.integer :shares

      t.timestamps
    end
  end
end
