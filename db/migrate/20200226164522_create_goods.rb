class CreateGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :goods do |t|
      t.integer :qnt, default: "0.0"
      t.string :item
      t.decimal :price, default: "0.0"
      t.string :description
      t.string :vendor
      t.decimal :sub_total, default: "0.0"
      t.decimal :taxx, default: "0.0"
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
