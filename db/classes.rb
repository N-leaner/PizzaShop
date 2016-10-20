module DbPizza
	class Product < ActiveRecord::Base

	end	

	class Order < ActiveRecord::Base
		validates :name, presence: true, length: {minimum: 3}
		validates :phone, presence: true
		validates :adress, presence: true	
	end	
end