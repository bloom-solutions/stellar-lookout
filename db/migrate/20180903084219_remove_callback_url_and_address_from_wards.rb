class RemoveCallbackUrlAndAddressFromWards < ActiveRecord::Migration[5.2]
  def change
    remove_column :wards, :callback_url, :string, null: false
    remove_column :wards, :secret, :string, null: false
  end
end
