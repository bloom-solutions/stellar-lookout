class CreateWards < ActiveRecord::Migration[5.0]
  def change
    create_table :wards do |t|
      t.string :address, null: false
      t.string :callback_url, null: false
      t.string :secret, null: false
      t.timestamps
    end

    add_index :wards, [:address, :callback_url], unique: true
  end
end
