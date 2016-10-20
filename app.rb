#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:pizzashop.db"

class Product < ActiveRecord::Base

end	

class Order < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3}
	validates :phone, presence: true
	validates :adress, presence: true	
end	

get '/' do
	@products = Product.all
	@ore = 0
	@order_inp = ''
	@order_bname = 'Your cart (..)'
	erb :index
end

get '/about' do
	erb :about
end	

get '/cart' do	
	redirect to '/'	
	#erb :cart
end	

get '/order' do	
	redirect to '/'
end	

get '/all_orders' do
	@orders = Order.order("created_at DESC")
	erb :all_orders
end	

def get_hh_order str
	arr = str.split(',')
	hh = {}
	arr.each do |i|
		arh = i.split('=')
		key = arh[0].split('_')[1]
		cnt = arh[1].to_i
		prod = Product.find(key)
		hh[key] = [prod,cnt]	
	end	
	return hh
end

def get_order_qvo hh
	it_qvo = 0	
	hh.each {|k,v| it_qvo = it_qvo + v[1]}
	return it_qvo.to_s
end	

def get_order_summ hh
	it_summ = 0
	hh.each do |k,v|
		price = v[0]['price']
		it_summ = it_summ + price*v[1]
	end	
	return it_summ
end	

post '/cart' do	
	@order_inp = params[:orders].strip
	@ore = 0	
	@hh_order = get_hh_order @order_inp		
	@order_bname = 'Your cart ( '+get_order_qvo(@hh_order)+' )'
	erb :cart
end	

post '/order'do	
	@ore = 1
	@order_inp = params[:order_conf].strip
	@hh_order = get_hh_order @order_inp

	erb :order
end

post '/order_done' do
	@order_inp = params[:order_conf].strip
	@hh_order = get_hh_order @order_inp

	@name_ = params[:username].strip
	@phone_ = params[:phone].strip
	@adress_ = params[:adress].strip

	@order_to_w = Order.new
	@order_to_w.name = @name_
	@order_to_w.phone = @phone_
	@order_to_w.adress = @adress_
	@order_to_w.descript_order = @order_inp
	@order_to_w.summa = get_order_summ @hh_order

	if @order_to_w.save
		@done = 'Thanks, your order is confirmed!'	
		@ore = 1
		erb :order_good
	else
		#@error = 'Ошибка записи - одно из полей не заполнено'
		@error = @order_to_w.errors.full_messages.first
		erb :order
	end	
end	

get '/order_done' do
	order_inp = params[:order_conf].strip
	@hh_order = get_hh_order order_inp
	erb :order
end	
