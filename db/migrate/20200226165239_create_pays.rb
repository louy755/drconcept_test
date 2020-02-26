class CreatePays < ActiveRecord::Migration[6.0]
  def change
    create_table :pays do |t|
      t.decimal :amount, default: "0.0"
      t.string :method
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
