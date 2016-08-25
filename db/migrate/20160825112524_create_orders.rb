class CreateOrders < ActiveRecord::Migration
  def change
  	create_table :orders do |t|
  		t.string :name
  		t.string :phone
  		t.string :adress
  		t.text :descript_order
  		t.decimal :summa

  		t.timestamps
  	end
  end
end
