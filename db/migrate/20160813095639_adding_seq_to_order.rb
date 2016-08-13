class AddingSeqToOrder < ActiveRecord::Migration[5.0]
  def up
  	 execute "CREATE SEQUENCE orders_id_seq OWNED BY
orders.id INCREMENT BY 1 START WITH 1"
  end
end
