#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './db/classes.rb'
require './helpers.rb'

set :database, "sqlite3:pizzashop.db"

#\\\\\\\\\\\GET////////////Begin
get '/' do
	@products = DbPizza::Product.all
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
	@orders = DbPizza::Order.order("created_at DESC")
	erb :all_orders
end	

get '/order_done' do
	order_inp = params[:order_conf].strip
	@hh_order = Helpers.get_hh_order order_inp
	erb :order
end	
#\\\\\\\\\\\GET////////////Eng

#\\\\\\\\\\\POST////////////Begin
post '/cart' do	
	@order_inp = params[:orders].strip
	@ore = 0	
	@hh_order = Helpers.get_hh_order @order_inp		
	@order_bname = 'Your cart ( '+Helpers.get_order_qvo(@hh_order)+' )'
	erb :cart
end	

post '/order'do	
	@ore = 1
	@order_inp = params[:order_conf].strip
	@hh_order = Helpers.get_hh_order @order_inp

	erb :order
end

post '/order_done' do
	@order_inp = params[:order_conf].strip
	@hh_order = Helpers.get_hh_order @order_inp

	@name_ = params[:username].strip
	@phone_ = params[:phone].strip
	@adress_ = params[:adress].strip

	@order_to_w = DbPizza::Order.new
	@order_to_w.name = @name_
	@order_to_w.phone = @phone_
	@order_to_w.adress = @adress_
	@order_to_w.descript_order = @order_inp
	@order_to_w.summa = Helpers.get_order_summ @hh_order

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
#\\\\\\\\\\\POST////////////End