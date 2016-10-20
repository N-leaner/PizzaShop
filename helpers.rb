module Helpers
	def Helpers.get_hh_order str
		arr = str.split(',')
		hh = {}
		arr.each do |i|
			arh = i.split('=')
			key = arh[0].split('_')[1]
			cnt = arh[1].to_i
			prod = DbPizza::Product.find(key)
			hh[key] = [prod,cnt]	
		end	
		return hh
	end

	def Helpers.get_order_summ hh
		it_summ = 0
		hh.each do |k,v|
			price = v[0]['price']
			it_summ = it_summ + price*v[1]
		end	
		return it_summ
	end

	def Helpers.get_order_qvo hh
		it_qvo = 0	
		hh.each {|k,v| it_qvo = it_qvo + v[1]}
		return it_qvo.to_s
	end	
end