class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.decimal :subtotal, default: "0.0"
      t.decimal :tax, default: "0.0"
      t.decimal :total, default: "0.0"
      t.string :sale_rep
      t.decimal :profit, default: "0.0"
      t.decimal :margin, default: "0.0"
      t.decimal :cost, default: "0.0"
      t.decimal :delivery, default: "0.0"
      t.decimal :fee, default: "0.0"
      t.decimal :discount, default: "0.0"
      t.boolean :finance, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
