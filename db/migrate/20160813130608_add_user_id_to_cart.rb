class AddUserIdToCart < ActiveRecord::Migration[5.0]
  def change
  	add_column :carts, :user_id, :integer, :default => nil
  end
end
